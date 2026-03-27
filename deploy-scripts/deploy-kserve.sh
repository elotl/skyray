# Nova is a K8s API that places workloads on other clusters — it cannot run pods.
# Disable cert-manager integration since Nova cannot run cert-manager webhooks.
# Full cert-manager must already be running on the workload clusters.
#
# Clean up any orphaned cert-manager webhook configs that block API calls on Nova
kubectl delete validatingwebhookconfiguration cert-manager-webhook 2>/dev/null || true
kubectl delete mutatingwebhookconfiguration cert-manager-webhook 2>/dev/null || true
#
helm install kserve-crd oci://ghcr.io/kserve/charts/kserve-crd --version v0.17.0-rc0 $1
#
# Create kserve namespace before generating the webhook cert secret
kubectl create namespace kserve 2>/dev/null || true
#
# Generate a self-signed TLS cert for the KServe webhook since cert-manager is disabled.
# The controller deployment mounts secret "kserve-webhook-server-cert" as a volume.
TMP_CERT_DIR=$(mktemp -d)
openssl req -x509 -newkey rsa:2048 -nodes -days 3650 \
  -keyout "${TMP_CERT_DIR}/tls.key" \
  -out "${TMP_CERT_DIR}/tls.crt" \
  -subj "/CN=kserve-webhook-server-service.kserve.svc" \
  -addext "subjectAltName=DNS:kserve-webhook-server-service.kserve.svc,DNS:kserve-webhook-server-service.kserve.svc.cluster.local" \
  2>/dev/null
kubectl delete secret kserve-webhook-server-cert -n kserve 2>/dev/null || true
kubectl create secret tls kserve-webhook-server-cert -n kserve \
  --cert="${TMP_CERT_DIR}/tls.crt" \
  --key="${TMP_CERT_DIR}/tls.key"
kubectl label secret kserve-webhook-server-cert -n kserve app.kubernetes.io/name=kserve
rm -rf "${TMP_CERT_DIR}"
#
helm install kserve oci://ghcr.io/kserve/charts/kserve --version v0.17.0-rc0 \
 --set kserve.controller.deploymentMode=Standard \
 --set kserve.certManager.enabled=false \
 -n kserve $1
#
# Delete KServe webhook configurations on the Nova control plane.
# Nova cannot run pods, so these webhooks will never reach the controller and
# block all InferenceService operations with timeout errors.
# The webhooks will still function on workload clusters where the controller runs.
kubectl delete mutatingwebhookconfiguration inferenceservice.serving.kserve.io 2>/dev/null || true
kubectl delete validatingwebhookconfiguration clusterservingruntime.serving.kserve.io 2>/dev/null || true
kubectl delete validatingwebhookconfiguration inferencegraph.serving.kserve.io 2>/dev/null || true
kubectl delete validatingwebhookconfiguration inferenceservice.serving.kserve.io 2>/dev/null || true
kubectl delete validatingwebhookconfiguration servingruntime.serving.kserve.io 2>/dev/null || true
kubectl delete validatingwebhookconfiguration trainedmodel.serving.kserve.io 2>/dev/null || true
#
# Label CRDs so Nova can duplicate them to all workload clusters
kubectl label crd clusterservingruntimes.serving.kserve.io   app.kubernetes.io/component=kserve
kubectl label crd clusterstoragecontainers.serving.kserve.io app.kubernetes.io/component=kserve
kubectl label crd inferencegraphs.serving.kserve.io          app.kubernetes.io/component=kserve
kubectl label crd inferenceservices.serving.kserve.io        app.kubernetes.io/component=kserve
kubectl label crd servingruntimes.serving.kserve.io          app.kubernetes.io/component=kserve
kubectl label crd trainedmodels.serving.kserve.io            app.kubernetes.io/component=kserve
#
# Label operator resources in kserve namespace (--overwrite in case helm already set a different value)
kubectl label cm/inferenceservice-config  -n kserve app.kubernetes.io/name=kserve --overwrite
kubectl label sa/kserve-controller-manager -n kserve app.kubernetes.io/name=kserve --overwrite
