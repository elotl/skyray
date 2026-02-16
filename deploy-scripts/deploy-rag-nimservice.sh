envsubst < ${RAG_PATH}/deploy/helm/nim-operator/rag-nimservice.yaml | kubectl apply -n ${APP_NAMESPACE} -f -

kubectl label nimservices.apps.nvidia.com/nim-llm                           -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimservice
kubectl label nimservices.apps.nvidia.com/nemoretriever-page-elements-v2    -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimservice
kubectl label nimservices.apps.nvidia.com/nemoretriever-graphic-elements-v1 -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimservice
kubectl label nimservices.apps.nvidia.com/nemoretriever-table-structure-v1  -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimservice
kubectl label nimservices.apps.nvidia.com/nemoretriever-embedding-ms        -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimservice
kubectl label nimservices.apps.nvidia.com/nemoretriever-ranking-ms          -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimservice
