#!/usr/bin/env bash

TARGET_CLUSTER=$1

kubectl nova uninstall control-plane --context=${TARGET_CLUSTER} nova
