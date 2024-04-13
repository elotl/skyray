#!/usr/bin/env bash

TARGET_CLUSTER=$1

kubectl nova --context=${TARGET_CLUSTER} uninstall agent ${TARGET_CLUSTER}
