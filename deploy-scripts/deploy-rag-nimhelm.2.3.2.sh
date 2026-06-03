helm upgrade --install rag -n ${APP_NAMESPACE} /home/anne/nvidia-blueprint-rag \
 --set imagePullSecret.password=$NGC_API_KEY   --set ngcApiSecret.password=$NGC_API_KEY \
 -f ${RAG_PATH}/deploy/helm/nim-operator/values-nim-operator.yaml

kubectl label sa/rag-minio         -n ${APP_NAMESPACE} app.kubernetes.io/instance=rag
kubectl label secret/rag-minio     -n ${APP_NAMESPACE} app.kubernetes.io/instance=rag
kubectl label cm/rag-minio         -n ${APP_NAMESPACE} app.kubernetes.io/instance=rag
kubectl label pvc/rag-minio        -n ${APP_NAMESPACE} app.kubernetes.io/instance=rag
kubectl label svc/rag-minio        -n ${APP_NAMESPACE} app.kubernetes.io/instance=rag
kubectl label deployment/rag-minio -n ${APP_NAMESPACE} app.kubernetes.io/instance=rag
kubectl label cm/milvus            -n ${APP_NAMESPACE} app.kubernetes.io/instance=rag
kubectl label cm/rag-nv-ingest     -n ${APP_NAMESPACE} app.kubernetes.io/instance=rag
