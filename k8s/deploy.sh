#!/bin/bash

deployment_order=(
    namespace.yaml
    stunner-auth-secret.yaml
    stunner/
    redis/
    edumeet/
    rabbitmq/
    pikaworker/
)

# Create secret with STUNner credentials to limit its access
kubectl -n sensecaremeet create secret generic stunner-auth-secret \
    --from-literal=type=static \
    --from-literal=username=${STUNNER_USER} \
    --from-literal=password=${STUNNER_PASSWORD} \
    --dry-run=client -o yaml > stunner-auth-secret.yaml

# Set those credentials in edumeet configuration
# ...unfortunately they must be hardcoded into the config file and cannot be provided via env vars
edumeet_config_path=edumeet/configmap-server.yaml
mv $edumeet_config_path ${edumeet_config_path}.tmp && \
envsubst < $edumeet_config_path.tmp > ${edumeet_config_path}

# Deploy in specified order
for component in ${deployment_order[@]}; do
    kubectl apply -f $component
done

# Clean up
rm $edumeet_config_path && mv ${edumeet_config_path}.tmp $edumeet_config_path
rm stunner-auth-secret.yaml