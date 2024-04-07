helm install kuberay-operator kuberay/kuberay-operator --version 1.1.0-rc.0
kubectl label crd rayclusters.ray.io app.kubernetes.io/component=kuberay-operator
kubectl label crd rayjobs.ray.io app.kubernetes.io/component=kuberay-operator
kubectl label crd rayservices.ray.io app.kubernetes.io/component=kuberay-operator
