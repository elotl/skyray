# Prerequisites: cert-manager must be installed (required by KServe webhooks)
#
helm install kserve-crd oci://ghcr.io/kserve/charts/kserve-crd --version v0.17.0 $1
helm install kserve oci://ghcr.io/kserve/charts/kserve --version v0.17.0 \
 --set kserve.controller.deploymentMode=Standard \
 -n kserve $1
#
# Label CRDs so Nova can duplicate them to all workload clusters
kubectl label crd clusterservingruntimes.serving.kserve.io   app.kubernetes.io/component=kserve
kubectl label crd clusterstoragecontainers.serving.kserve.io app.kubernetes.io/component=kserve
kubectl label crd inferencegraphs.serving.kserve.io          app.kubernetes.io/component=kserve
kubectl label crd inferenceservices.serving.kserve.io        app.kubernetes.io/component=kserve
kubectl label crd servingruntimes.serving.kserve.io          app.kubernetes.io/component=kserve
kubectl label crd trainedmodels.serving.kserve.io            app.kubernetes.io/component=kserve
#
# Label operator resources in kserve namespace that may not already have app.kubernetes.io/name=kserve
kubectl label cm/inferenceservice-config  -n kserve app.kubernetes.io/name=kserve
kubectl label sa/kserve-controller-manager -n kserve app.kubernetes.io/name=kserve
