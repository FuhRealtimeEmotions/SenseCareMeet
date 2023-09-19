# STUNner Dataplane Deployment

The STUNner dataplane deployment is the STUN/TURN server itself. It is deployed per WebRTC architecture/application deployment in a K8s cluster.

## Prerequisites

For the dataplane deployment the STUNer control plane components (primary the STUNner operator) is required. Since it is a per cluster component, it is not managed here on WebRTC application level. Nevertheless it can be easily deployed with Helm (see below).

## Manifests Source

The manifests are generated from the official STUNner Helm Chart:

```bash
helm repo add stunner https://l7mp.io/stunner
helm repo update
# Install control plane if not already present in cluster
# helm install stunner-gateway-operator stunner/stunner-gateway-operator --create-namespace --namespace=stunner-system
# Render dataplane manifests
helm template stunner stunner/stunner --include-crds --output-dir=<output-dir>
```

## Deploy

`kubectl apply -f .`