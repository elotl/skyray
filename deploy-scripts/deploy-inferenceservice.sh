envsubst < ${SKYRAY_PATH}/deploy-scripts/inference-service.sample.yaml | kubectl apply -n ${APP_NAMESPACE} -f -
kubectl label inferenceservices.serving.kserve.io/${INFERENCE_SERVICE_NAME} -n ${APP_NAMESPACE} app.kubernetes.io/instance=inferenceservice
