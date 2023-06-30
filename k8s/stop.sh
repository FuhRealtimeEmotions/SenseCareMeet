
minikube kubectl -- delete -f configmap-edumeet.yaml
minikube kubectl -- delete -f configmap-coturn.yaml
minikube kubectl -- delete -f deployment-coturn.yaml
minikube kubectl -- delete -f deployment-redis.yaml
minikube kubectl -- delete -f deployment-edumeet.yaml
minikube kubectl -- delete -f deployment-pikaworker.yaml
