set -e

# Create cluster with default mini-node pool (we cannot name the default-pool at cluster creation)
gcloud container clusters create "${CLUSTER_NAME}" \
  --project "${PROJECT_ID}" \
  --zone "${CLUSTER_LOCATION}" \
  --cluster-version "1.30.3-gke.1969001" \
  --release-channel "regular" \
  --machine-type "e2-medium" \
  --disk-type "pd-balanced" \
  --disk-size "10" \
  --num-nodes "1" \
  --node-locations "${CLUSTER_LOCATION}"

# Create node pools for Apigee
# From experimentation, e2-standard-2 for a very small Cassandra + e2-standard-4
# for the other runtime services (including a small Redis), seems to be a good start.
gcloud container node-pools create "apigee-data" \
  --project "${PROJECT_ID}" \
  --cluster "${CLUSTER_NAME}" \
  --zone "${CLUSTER_LOCATION}" \
  --machine-type "e2-standard-2" \
  --node-locations "${CLUSTER_LOCATION}"
gcloud container node-pools create "apigee-runtime" \
  --project "${PROJECT_ID}" \
  --cluster "${CLUSTER_NAME}" \
  --zone "${CLUSTER_LOCATION}" \
  --machine-type "e2-standard-4" \
  --node-locations "${CLUSTER_LOCATION}"

# Deletes the no longer needed default-pool
gcloud container node-pools delete default-pool \
  --project "${PROJECT_ID}" \
  --cluster "${CLUSTER_NAME}" \
  --zone "${CLUSTER_LOCATION}"

gcloud container clusters get-credentials "${CLUSTER_NAME}" \
  --zone "${CLUSTER_LOCATION}" \
  --project "${PROJECT_ID}"

gcloud container clusters update "${CLUSTER_NAME}" \
  --workload-pool="${PROJECT_ID}.svc.id.goog" \
  --project "${PROJECT_ID}" \
  --zone "${CLUSTER_LOCATION}"
