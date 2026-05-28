envsubst < ${SKYRAY_PATH}/deploy-scripts/agg.yaml | kubectl apply -n ${APP_NAMESPACE} -f -
