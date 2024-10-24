# Ref: https://cloud.google.com/apigee/docs/hybrid/v1.13/precog-enableapi
set -x

gcloud services enable \
    apigee.googleapis.com \
    apigeeconnect.googleapis.com \
    cloudresourcemanager.googleapis.com \
    compute.googleapis.com \
    container.googleapis.com \
    pubsub.googleapis.com --project $PROJECT_ID
