helm uninstall kserve -n kserve $1
helm uninstall kserve-crd $1
#
kubectl delete crd clusterservingruntimes.serving.kserve.io
kubectl delete crd clusterstoragecontainers.serving.kserve.io
kubectl delete crd inferencegraphs.serving.kserve.io
kubectl delete crd inferenceservices.serving.kserve.io
kubectl delete crd servingruntimes.serving.kserve.io
kubectl delete crd trainedmodels.serving.kserve.io
#
# Remove cert-manager CRDs that were installed for Nova control plane
# WARNING: only delete if no other operators depend on cert-manager CRDs
kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/v1.17.2/cert-manager.crds.yaml
