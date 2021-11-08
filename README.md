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
replace the k3s hostmachine ip with relevant address.

You can test the application by going to http://acceptpython.test and posting on the form field

You should get page with ACCEPTED and your post repeated

you can see the pod logging the accepted message by running:

```
kubectl logs $(kubectl get pods | grep acceptpython | awk {'print $1'})
```