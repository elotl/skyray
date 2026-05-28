kubectl create secret generic hf-token-secret -n ${APP_NAMESPACE} --from-literal=HF_TOKEN="${HF_TOKEN}"
kubectl label secret -n ${APP_NAMESPACE} hf-token-secret app=secret-${APP_NAMESPACE}
