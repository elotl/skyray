helm uninstall kuberay-operator $1
kubectl delete crd/rayclusters.ray.io
kubectl delete crd/rayjobs.ray.io
kubectl delete crd/rayservices.ray.io
