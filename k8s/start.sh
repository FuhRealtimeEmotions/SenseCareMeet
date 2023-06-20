#!/bin/bash

#minikube start --driver=qemu2 --container-runtime=cri-o
#minikube ssh "sudo sysctl -w fs.inotify.max_user_watches=1048576"
###############
#funzt nicht ##
###############
#minikube start --extra-config='kubelet.allowed-unsafe-sysctls="fs.inotify.*"'

kubectl apply -f configmap-edumeet.yaml
kubectl apply -f deployment-redis.yaml
kubectl apply -f deployment-edumeet.yaml
kubectl apply -f deployment-pika.yaml