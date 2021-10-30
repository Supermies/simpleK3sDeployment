#!/bin/bash

kubectl delete ingress acceptpython-ingress
kubectl delete service acceptpython-app
kubectl delete deployments.apps acceptpython-app
docker rmi acceptpython:1.0
/usr/local/bin/k3s-uninstall.sh
