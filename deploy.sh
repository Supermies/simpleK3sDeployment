#!/bin/bash

set -e

if ! command -v kubectl
then 
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy traefik --docker" sh -s -
fi

if ! kubectl get deployments -n ingress-nginx | grep nginx
then
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-0.32.0/deploy/static/provider/cloud/deploy.yaml
fi

if ! docker images | grep acceptpython
then 
    cd acceptpython
    docker build . -t acceptpython:1.0 
    cd ../
fi 

if ! kubectl get deployments | grep acceptpython 
then
    kubectl create deployment acceptpython-app --image=acceptpython:1.0
    kubectl expose deployment acceptpython-app --type=NodePort --port=5000
    kubectl apply -f kubeconf/acceptpython-ingress.yaml
fi