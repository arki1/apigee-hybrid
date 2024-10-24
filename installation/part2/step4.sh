# Ref: https://cloud.google.com/apigee/docs/hybrid/v1.13/install-service-accounts
set -e
set -x

# If a command fails, you can safely execute this part again or just the failing one.

chmod +x $APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account
$APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account --help

$APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account \
  --profile apigee-cassandra \
  --env prod \
  --dir $APIGEE_HELM_CHARTS_HOME/apigee-datastore

$APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account \
  --profile apigee-logger \
  --env prod \
  --dir $APIGEE_HELM_CHARTS_HOME/apigee-telemetry

$APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account \
  --profile apigee-mart \
  --env prod \
  --dir $APIGEE_HELM_CHARTS_HOME/apigee-org

$APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account \
  --profile apigee-metrics \
  --env prod \
  --dir $APIGEE_HELM_CHARTS_HOME/apigee-telemetry

$APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account \
  --profile apigee-runtime \
  --env prod \
  --dir $APIGEE_HELM_CHARTS_HOME/apigee-env

$APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account \
  --profile apigee-synchronizer \
  --env prod \
  --dir $APIGEE_HELM_CHARTS_HOME/apigee-env

$APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account \
  --profile apigee-udca \
  --env prod \
  --dir $APIGEE_HELM_CHARTS_HOME/apigee-env

$APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account \
  --profile apigee-udca \
  --env prod \
  --dir $APIGEE_HELM_CHARTS_HOME/apigee-org

$APIGEE_HELM_CHARTS_HOME/apigee-operator/etc/tools/create-service-account \
  --profile apigee-watcher \
  --env prod \
  --dir $APIGEE_HELM_CHARTS_HOME/apigee-org

cp $APIGEE_HELM_CHARTS_HOME/apigee-org/$PROJECT_ID-apigee-udca.json $APIGEE_HELM_CHARTS_HOME/apigee-env/

# Check if all service accounts were created with non-zero length
pushd $APIGEE_HELM_CHARTS_HOME
  find -type f -iname "${PROJECT_ID}*.json" | xargs ls -l
popd