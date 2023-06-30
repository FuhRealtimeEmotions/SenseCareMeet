#!/bin/bash

#minikube start --driver=qemu --network=default --container-runtime=cri-o
#minikube start --driver=kvm2 --network=default --container-runtime=cri-o
#minikube ssh "sudo sysctl -w fs.inotify.max_user_watches=1048576"
###############
#funzt nicht ##
###############
#minikube start --extra-config='kubelet.allowed-unsafe-sysctls="fs.inotify.*"'

# openssl req -x509 -newkey rsa:4096 -keyout privkey.pem -out cert.pem -days 365 -nodes

minikube kubectl -- apply -f configmap-edumeet.yaml
minikube kubectl -- apply -f configmap-coturn.yaml
minikube kubectl -- apply -f deployment-coturn.yaml
minikube kubectl -- apply -f deployment-redis.yaml
minikube kubectl -- apply -f deployment-edumeet.yaml
minikube kubectl -- apply -f deployment-pikaworker.yaml
