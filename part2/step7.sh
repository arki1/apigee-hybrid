set -e
set -x

gcloud iam service-accounts list --project "${PROJECT_ID}" --filter "apigee-synchronizer"

curl -sS --fail -X POST -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type:application/json" \
  "https://apigee.googleapis.com/v1/organizations/${ORG_NAME}:setSyncAuthorization" \
   -d '{"identities":["'"serviceAccount:apigee-synchronizer@${ORG_NAME}.iam.gserviceaccount.com"'"]}'

curl -sS --fail -X GET -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type:application/json" \
  "https://apigee.googleapis.com/v1/organizations/${ORG_NAME}:getSyncAuthorization" | jq .