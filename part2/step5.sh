set -e
set -x

mkdir $APIGEE_HELM_CHARTS_HOME/apigee-virtualhost/certs/
openssl req  -nodes -new -x509 -keyout $APIGEE_HELM_CHARTS_HOME/apigee-virtualhost/certs/keystore_$ENV_GROUP.key -out \
    $APIGEE_HELM_CHARTS_HOME/apigee-virtualhost/certs/keystore_$ENV_GROUP.pem -subj '/CN='$DOMAIN'' -days 3650

ls $APIGEE_HELM_CHARTS_HOME/apigee-virtualhost/certs