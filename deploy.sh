#!/bin/bash

### Deployment script for installing k3s locally with nginx ingress controller, building the application image and running it on the local k3s cluster ###
set -e

# check if kubectl is available and install k3s with traefik ingress disabled and local docker enabled.
if ! command -v kubectl
then 
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy traefik --docker" sh -s -
fi

# install nginx ingress controller for k3s
if ! kubectl get deployments -n ingress-nginx | grep nginx
then
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-0.32.0/deploy/static/provider/cloud/deploy.yaml
fi

# build locally the application image. Could add versioning
if ! docker images | grep acceptpython
then 
    cd acceptpython
    docker build . -t acceptpython:1.0 
    cd ../
fi 

# deploy the built application to local k3s server
if ! kubectl get deployments | grep acceptpython 
then
    kubectl create deployment acceptpython-app --image=acceptpython:1.0
    kubectl expose deployment acceptpython-app --type=NodePort --port=5000
    kubectl apply -f kubeconf/acceptpython-ingress.yaml
fi
### remember to add the k3s ip to your hosts file with acceptpython.test as hostname for access to deployment application ###