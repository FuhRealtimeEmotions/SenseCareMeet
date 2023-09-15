# SenseCareMeet K8s Deployment

## Prerequisites 

K8s Cluster with

* the ability to provision a dedicated internet-facing Network Load Balancer (L4) for incoming UDP connections
* STUNner to allow the operation of a WebRTC architecture including STUN/TURN service within Kubernetes
* cert-manager to automate certificate creation and renewal
* external-dns to automate the creation of DNS records for ingress resources
* ImagePullSecret to pull the SenceCareMeet image from ghcr.io

## How to deploy

There is a `deploy.sh` script in this directory. It takes into account the correct deployment order of the different components.