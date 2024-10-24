# Ref: https://cloud.google.com/apigee/docs/hybrid/v1.13/install-create-overrides
# This step provides a starting version of your overrides.yaml.
# Change it properly to meet the required needs for your environment.
set -e

OVERRIDES="$APIGEE_HELM_CHARTS_HOME/overrides.yaml"
cat > "$OVERRIDES" <<EOF
instanceID: "$ORG_NAME"
namespace: $APIGEE_NAMESPACE

gcp:
  projectID: $PROJECT_ID
  region: $CLUSTER_REGION

k8sCluster:
  name: $CLUSTER_NAME
  region: $CLUSTER_LOCATION
org: $ORG_NAME

envs:
- name: $ENV_NAME
  serviceAccountPaths:
    # Provide the path relative to the chart directory.
    synchronizer: $PROJECT_ID-apigee-synchronizer.json
    runtime: $PROJECT_ID-apigee-runtime.json
    udca: $PROJECT_ID-apigee-udca.json

cassandra:
  hostNetwork: false
  backup:
    enabled: true
    image:
      pullPolicy: Always
    cloudProvider: CSI
    schedule: '0 * * 11 *'

ingressGateways:
- name: apigee-ingress
  replicaCountMin: 2
  replicaCountMax: 4

virtualhosts:
- name: $ENV_GROUP
  selector:
    app: apigee-ingressgateway
    ingress_name: apigee-ingress
  sslCertPath: "certs/keystore_eval-group.pem"
  sslKeyPath: "certs/keystore_eval-group.key"

mart:
  serviceAccountPath: "$PROJECT_ID-apigee-mart.json"

connectAgent:
  serviceAccountPath: "$PROJECT_ID-apigee-mart.json"

logger:
  enabled: true
  serviceAccountPath: "$PROJECT_ID-apigee-logger.json"

metrics:
  enabled: true
  serviceAccountPath: "$PROJECT_ID-apigee-metrics.json"

udca:
  serviceAccountPath: "$PROJECT_ID-apigee-udca.json"

watcher:
  serviceAccountPath: "$PROJECT_ID-apigee-watcher.json"
EOF

go run github.com/mikefarah/yq/v4@latest "$OVERRIDES"
