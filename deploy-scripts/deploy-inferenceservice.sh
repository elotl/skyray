SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
envsubst < "${SCRIPT_DIR}/inference-service.sample.yaml" | kubectl apply -n ${APP_NAMESPACE} -f -
kubectl label inferenceservices.serving.kserve.io/${INFERENCE_SERVICE_NAME} -n ${APP_NAMESPACE} app.kubernetes.io/instance=inferenceservice
