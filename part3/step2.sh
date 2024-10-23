echo "Testing $DOMAIN (with curl --resolve) ..."

INGRESS_IP_ADDRESS=$(kubectl get svc -n $APIGEE_NAMESPACE -l app=apigee-ingressgateway \
    -o jsonpath="{.items[0].status.loadBalancer.ingress[0].ip}")
INGRESS_PORT=443

# TODO: Deploy the mock target via Apigee Console using the reverse proxy to
# https://mocktarget.apigee.net

# After deployment is complete, test it with curl:
curl -k -sS --fail \
    -H Host:$DOMAIN \
    --resolve $DOMAIN:$INGRESS_PORT:$INGRESS_IP_ADDRESS \
    https://$DOMAIN:$INGRESS_PORT/hello/v1/echo | jq .
