# Ref: https://cloud.google.com/apigee/docs/hybrid/v1.13/install-cert-manager
set -e

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.1/cert-manager.yaml
kubectl get all -n cert-manager -o wide
