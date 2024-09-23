set -e
set -x

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

cd $APIGEE_HELM_CHARTS_HOME

# Apigee Operator/Controller
helm upgrade operator apigee-operator/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml \
  --dry-run
helm upgrade operator apigee-operator/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml
kubectl -n apigee get deploy apigee-controller-manager

# Apigee Datastore
helm upgrade datastore apigee-datastore/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml \
  --dry-run=server
helm upgrade datastore apigee-datastore/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml
kubectl -n apigee get apigeedatastore default

# Apigee Telemetry
helm upgrade telemetry apigee-telemetry/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml \
  --dry-run
helm upgrade telemetry apigee-telemetry/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml
kubectl -n apigee get apigeetelemetry apigee-telemetry

# Apigee Redis
helm upgrade redis apigee-redis/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml \
  --dry-run
helm upgrade redis apigee-redis/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml
kubectl -n apigee get apigeeredis default

# Ingress Manager
helm upgrade ingress-manager apigee-ingress-manager/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml \
  --dry-run
helm upgrade ingress-manager apigee-ingress-manager/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml
kubectl -n apigee get deployment apigee-ingressgateway-manager

# Apigee Organization
helm upgrade $ORG_NAME apigee-org/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml \
  --dry-run
helm upgrade $ORG_NAME apigee-org/ \
  --install \
  --namespace apigee \
  --atomic \
  -f overrides.yaml
kubectl -n apigee get apigeeorg

# Apigee Environment
helm upgrade $ENV_NAME apigee-env/ \
  --install \
  --namespace apigee \
  --atomic \
  --set env=$ENV_NAME \
  -f overrides.yaml \
  --dry-run
helm upgrade $ENV_NAME apigee-env/ \
  --install \
  --namespace apigee \
  --atomic \
  --set env=$ENV_NAME \
  -f overrides.yaml
kubectl -n apigee get apigeeenv

# Env Groups
helm upgrade $ENV_GROUP apigee-virtualhost/ \
  --install \
  --namespace apigee \
  --atomic \
  --set envgroup=$ENV_GROUP \
  -f overrides.yaml \
  --dry-run
helm upgrade $ENV_GROUP apigee-virtualhost/ \
  --install \
  --namespace apigee \
  --atomic \
  --set envgroup=$ENV_GROUP \
  -f overrides.yaml
kubectl -n apigee get arc
kubectl -n apigee get ar