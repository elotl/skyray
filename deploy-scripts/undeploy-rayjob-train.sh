RAYCLUSTER_NAMESPACE=$1

kubectl delete namespace ${RAYCLUSTER_NAMESPACE}
kubectl delete schedulepolicy rayjob-capacity-policy-${RAYCLUSTER_NAMESPACE}
