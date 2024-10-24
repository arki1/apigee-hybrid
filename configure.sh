# Apigee setings
export PROJECT_ID="$(gcloud config get project)"
export RUNTIMEVERSION=1.13.1
export RUNTIMETYPE=HYBRID
export ANALYTICS_REGION="us-central1"
export ORG_NAME="$PROJECT_ID"
export ENV_NAME="eval"
export ENV_GROUP="eval-group"

# GKE settings
export CLUSTER_NAME="apigee-hybrid"
export CLUSTER_REGION="${ANALYTICS_REGION}" # GCE Region
export CLUSTER_LOCATION="${ANALYTICS_REGION}-c" # GCE Zone

# Changing the DOMAIN later requires a new certificate; use the helm upgrade command
export DOMAIN="hybrid.apigee.net"

# Apigee K8S Helm Charts and Namespace setup
export APIGEE_HELM_CHARTS_HOME=$HOME/workspace/apigee-hybrid/helm-charts
export APIGEE_NAMESPACE=apigee

# These are auth helpers
export TOKEN=$(gcloud auth print-access-token)
gcloud container clusters get-credentials "${CLUSTER_NAME}" \
  --zone "${CLUSTER_LOCATION}" \
  --project "${PROJECT_ID}" >/dev/null 2>&1 || echo "Kubernetes cluster not found."
kubectl config set-context --current --namespace=apigee

# Update to Helm 3.10+
HELM_VERSION="$(helm version --template '{{.Version}}'|cut -f 2 -dv)"
if ! dpkg --compare-versions "$HELM_VERSION" ge 3.10.0 ; then
    pushd /tmp
    wget "https://get.helm.sh/helm-v3.16.1-linux-amd64.tar.gz"
    tar xf helm-v3.16.1-linux-amd64.tar.gz
    sudo mv -f linux-amd64/helm /usr/local/bin/helm
    chmod +x /usr/local/bin/helm
    popd
fi