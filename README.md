# simpleK3sDeployment
This installs k3s and deploys a simple flask container to k3s with nginx ingress

Requirements: Linux, Docker

Tested on: 

Ubuntu:18.04

docker:20.10.7

To deploy the application run
```
sh deploy.sh
```
After running the script you need to add the following to the hosts file of the machine you are accessing the running app from:
```
<k3shostmachineip> acceptpython.test
```
