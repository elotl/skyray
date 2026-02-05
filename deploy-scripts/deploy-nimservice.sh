kubectl apply -f ${SKYRAY_PATH}/deploy-scripts/nim-service.sample.yaml -n ${APP_NAMESPACE}
kubectl label nimservices.apps.nvidia.com/phi-3-mini-4k-instruct -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimservice
