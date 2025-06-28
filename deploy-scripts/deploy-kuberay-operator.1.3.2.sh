helm install kuberay-operator kuberay/kuberay-operator --version 1.3.2 \
 --set-json 'env=[{"name":"ENABLE_RAY_HEAD_CLUSTER_IP_SERVICE","value":"true"}]' \
 $1
kubectl label crd rayclusters.ray.io app.kubernetes.io/component=kuberay-operator
kubectl label crd rayjobs.ray.io app.kubernetes.io/component=kuberay-operator
kubectl label crd rayservices.ray.io app.kubernetes.io/component=kuberay-operator
