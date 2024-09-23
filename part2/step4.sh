set -e
set -x

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