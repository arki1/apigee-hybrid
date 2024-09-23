# Source this at Cloud Shell should be idempotent
export TOKEN=$(gcloud auth print-access-token)

# Global setings
export PROJECT_ID="training-gcp-demos"
export ORG_NAME="$PROJECT_ID"
export ANALYTICS_REGION="us-central1"
export RUNTIMETYPE=HYBRID

# Apigee Env/Env Group settings
# Changing the DOMAIN later requires a new certificate; use the helm upgrade command
export DOMAIN="hybrid.api.ronoaldo.dev.br"
export ENV_NAME="eval"
export ENV_GROUP="eval-group"

# GKE settings
export CLUSTER_NAME="apigee-hybrid-cluster"
export CLUSTER_REGION="us-central1"
export CLUSTER_LOCATION="us-central1-c"

# Apigee K8S Helm Charts and Namespace setup
export APIGEE_HELM_CHARTS_HOME=$HOME/workspace/apigee-hybrid/helm-charts
export APIGEE_NAMESPACE=apigee
