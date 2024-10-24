# Ref: https://cloud.google.com/apigee/docs/hybrid/v1.13/install-expose-apigee-ingress
set -e

kubectl get svc -n $APIGEE_NAMESPACE -l app=apigee-ingressgateway

INGRESS_IP_ADDRESS=$(kubectl get svc -n $APIGEE_NAMESPACE -l app=apigee-ingressgateway -o jsonpath="{.items[0].status.loadBalancer.ingress[0].ip}")
curl -H 'User-Agent: GoogleHC' https://$DOMAIN/healthz/ingress -k \
  --resolve "$DOMAIN:443:$INGRESS_IP_ADDRESS"
echo