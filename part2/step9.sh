set -e
set -x

cd $APIGEE_HELM_CHARTS_HOME

kubectl apply -k  apigee-operator/etc/crds/default/ \
  --server-side \
  --force-conflicts \
  --validate=false \
  --dry-run=server
kubectl apply -k  apigee-operator/etc/crds/default/ \
  --server-side \
  --force-conflicts \
  --validate=false

kubectl get crds | grep apigee