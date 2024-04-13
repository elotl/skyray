#!/usr/bin/env bash

TARGET_CLUSTER=$1
IMAGE_TAG=$2

kubectl nova install control-plane --context ${TARGET_CLUSTER} --namespace=elotl --image-repository=elotl/nova-scheduler-dev --image-tag=${IMAGE_TAG} nova
