# Ref: https://cloud.google.com/apigee/docs/hybrid/v1.13/precog-add-environment
set -e

curl -sS --fail -H "Authorization: Bearer $TOKEN" -X POST -H "content-type:application/json"   -d '{
    "name": "'"$ENV_NAME"'"
  }'   "https://apigee.googleapis.com/v1/organizations/$ORG_NAME/environments"

curl -sS --fail -H "Authorization: Bearer $TOKEN" -X POST -H "content-type:application/json" \
   -d '{
     "name": "'"$ENV_GROUP"'",
     "hostnames":["'"$DOMAIN"'"]
   }' \
   "https://apigee.googleapis.com/v1/organizations/$ORG_NAME/envgroups"

curl -sS --fail -H "Authorization: Bearer $TOKEN" -X POST -H "content-type:application/json" \
   -d '{
     "environment": "'"$ENV_NAME"'",
   }' \
   "https://apigee.googleapis.com/v1/organizations/$ORG_NAME/envgroups/$ENV_GROUP/attachments"