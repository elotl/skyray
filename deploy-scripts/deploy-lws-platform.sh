export CHART_VERSION=0.8.0
helm install lws oci://registry.k8s.io/lws/charts/lws --version=$CHART_VERSION --namespace lws-system

kubectl label secret lws-webhook-server-cert --namespace lws-system               app.kubernetes.io/name=lws
kubectl label validatingwebhookconfiguration lws-validating-webhook-configuration app.kubernetes.io/name=lws
kubectl label mutatingwebhookconfiguration lws-mutating-webhook-configuration     app.kubernetes.io/name=lws

kubectl patch validatingwebhookconfiguration lws-validating-webhook-configuration \
  --type='json' \
  -p='[
    {"op": "replace", "path": "/webhooks/0/failurePolicy", "value": "Ignore"},
    {"op": "replace", "path": "/webhooks/0/timeoutSeconds", "value": 3},
    {"op": "replace", "path": "/webhooks/1/failurePolicy", "value": "Ignore"},
    {"op": "replace", "path": "/webhooks/1/timeoutSeconds", "value": 3}
  ]'

kubectl patch mutatingwebhookconfiguration lws-mutating-webhook-configuration \
  --type='json' \
  -p='[
    {"op": "replace", "path": "/webhooks/0/failurePolicy", "value": "Ignore"},
    {"op": "replace", "path": "/webhooks/0/timeoutSeconds", "value": 3},
    {"op": "replace", "path": "/webhooks/1/failurePolicy", "value": "Ignore"},
    {"op": "replace", "path": "/webhooks/1/timeoutSeconds", "value": 3}
  ]'
