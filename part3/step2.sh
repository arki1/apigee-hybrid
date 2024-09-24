echo "Testing $DOMAIN (with curl --resolve) ..."

INGRESS_IP_ADDRESS=$(kubectl get svc -n $APIGEE_NAMESPACE -l app=apigee-ingressgateway \
    -o jsonpath="{.items[0].status.loadBalancer.ingress[0].ip}")
INGRESS_PORT=443

curl -k -sS --fail \
    -H Host:$DOMAIN \
    --resolve $DOMAIN:$INGRESS_PORT:$INGRESS_IP_ADDRESS \
    https://$DOMAIN:$INGRESS_PORT/mock/echo | jq .