#!/usr/bin/env bash

TARGET_CLUSTER=$1
IMAGE_TAG=$2

kubectl --context=${TARGET_CLUSTER} create namespace elotl
kubectl --context=nova get secret -n elotl nova-cluster-init-kubeconfig -o yaml | kubectl --context=${TARGET_CLUSTER} apply -f -
kubectl nova install agent --context ${TARGET_CLUSTER} --namespace=elotl --image-repository=elotl/nova-agent-dev --image-tag=${IMAGE_TAG} ${TARGET_CLUSTER}
