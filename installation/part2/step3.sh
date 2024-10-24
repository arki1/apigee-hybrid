# Ref: https://cloud.google.com/apigee/docs/hybrid/v1.13/install-create-namespace
set -e

kubectl create namespace $APIGEE_NAMESPACE
kubectl get namespace $APIGEE_NAMESPACE