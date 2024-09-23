set -e

kubectl create namespace $APIGEE_NAMESPACE
kubectl get namespace $APIGEE_NAMESPACE