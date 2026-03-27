helm uninstall kserve -n kserve $1
helm uninstall kserve-crd $1
#
kubectl delete crd clusterservingruntimes.serving.kserve.io
kubectl delete crd clusterstoragecontainers.serving.kserve.io
kubectl delete crd inferencegraphs.serving.kserve.io
kubectl delete crd inferenceservices.serving.kserve.io
kubectl delete crd servingruntimes.serving.kserve.io
kubectl delete crd trainedmodels.serving.kserve.io
