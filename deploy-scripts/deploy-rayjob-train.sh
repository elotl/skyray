#!/usr/bin/env bash
set -e

SKYRAY_PATH=$1
RAYCLUSTER_NAMESPACE=$2

# needed to fetch s3 data for training job
AWS_ACCESS_KEY_ID=$3
AWS_SECRET_ACCESS_KEY=$4

export RAYCLUSTER_NAMESPACE
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

echo "Spread-schedule namespace in which to run job"
kubectl apply -f ${SKYRAY_PATH}/policies/nspolicy.yaml
envsubst < ${SKYRAY_PATH}/deploy-scripts/namespace.yaml | kubectl apply -f -
sleep 30 # wait for namespace workload placement

echo "Place training ray job on cluster w/sufficient capacity; job runs until terminal state or 600s time-out"
envsubst < ${SKYRAY_PATH}/policies/rayjobcapacitypolicy.yaml | kubectl apply -f -
envsubst < ${SKYRAY_PATH}/deploy-scripts/ray-job.train.yaml | kubectl apply --namespace ${RAYCLUSTER_NAMESPACE} -f -
