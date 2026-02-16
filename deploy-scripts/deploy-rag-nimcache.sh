kubectl apply -f ${RAG_PATH}/deploy/helm/nim-operator/rag-nimcache.yaml -n ${APP_NAMESPACE}

kubectl label nimcache.apps.nvidia.com/nemoretriever-page-elements-v2 -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimcache
kubectl label nimcache.apps.nvidia.com/nemoretriever-graphic-elements-v1 -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimcache
kubectl label nimcache.apps.nvidia.com/nemoretriever-table-structure-v1 -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimcache
kubectl label nimcache.apps.nvidia.com/nvidia-nim-llama-32-nv-embedqa-1b-v2 -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimcache
kubectl label nimcache.apps.nvidia.com/nvidia-nim-llama-32-nv-rerankqa-1b-v2 -n ${APP_NAMESPACE} app.kubernetes.io/instance=nimcache
