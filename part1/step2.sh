set -e

# Create the organization
if [ ! -f step2.out.json ]; then
    echo "Creating organization $ORG_NAME with type $RUNTIMETYPE"
    curl -sS -H "Authorization: Bearer $TOKEN" -X POST -H "content-type:application/json" \
    -d '{
        "name":"'"$ORG_NAME"'",
        "runtimeType":"'"$RUNTIMETYPE"'",
        "analyticsRegion":"'"$ANALYTICS_REGION"'"
    }' \
    "https://apigee.googleapis.com/v1/organizations?parent=projects/$PROJECT_ID" > step2.out.json
fi

# Check if the organization is ready
LRO_ID="$(jq -r '.name' step2.out.json | cut -f 4 -d '/')"
echo -n "Checking if organization is ready ($LRO_ID) "
while [ x"$STATUS" != x"FINISHED" ]; do
    curl -sS -H "Authorization: Bearer $TOKEN" \
        "https://apigee.googleapis.com/v1/organizations/$ORG_NAME/operations/$LRO_ID" \
        > step2.lro.json
    export STATUS="$(jq -r .metadata.state step2.lro.json)"
    echo -n "."
    sleep 5
done
echo "$STATUS"

# Print organization info, including billing type
curl -sS -H "Authorization: Bearer $TOKEN" \
  "https://apigee.googleapis.com/v1/organizations/$ORG_NAME" | jq '.'