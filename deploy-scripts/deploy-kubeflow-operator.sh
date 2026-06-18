kubectl apply --server-side -k "github.com/kubeflow/training-operator.git/manifests/overlays/standalone?ref=v1.8.1"

kubectl label customresourcedefinition.apiextensions.k8s.io/mpijobs.kubeflow.org                                   app=training-operator
kubectl label customresourcedefinition.apiextensions.k8s.io/mxjobs.kubeflow.org                                    app=training-operator
kubectl label customresourcedefinition.apiextensions.k8s.io/paddlejobs.kubeflow.org                                app=training-operator
kubectl label customresourcedefinition.apiextensions.k8s.io/pytorchjobs.kubeflow.org                               app=training-operator
kubectl label customresourcedefinition.apiextensions.k8s.io/tfjobs.kubeflow.org                                    app=training-operator
kubectl label customresourcedefinition.apiextensions.k8s.io/xgboostjobs.kubeflow.org                               app=training-operator

kubectl label clusterrole.rbac.authorization.k8s.io/training-operator                                              app=training-operator
kubectl label secret/training-operator-webhook-cert                                                                app=training-operator -n kubeflow
kubectl label deployment.apps/training-operator                                                                    app=training-operator -n kubeflow

kubectl label validatingwebhookconfiguration.admissionregistration.k8s.io/validator.training-operator.kubeflow.org app=training-operator

# Note: could have Nova policy w/overrides patch webhook settings back to original values in the target cluster(s)
kubectl patch validatingwebhookconfiguration validator.training-operator.kubeflow.org \
  --type='json' \
  -p='[
    {"op": "replace", "path": "/webhooks/0/failurePolicy", "value": "Ignore"},
    {"op": "replace", "path": "/webhooks/0/timeoutSeconds", "value": 3},
    {"op": "replace", "path": "/webhooks/1/failurePolicy", "value": "Ignore"},
    {"op": "replace", "path": "/webhooks/1/timeoutSeconds", "value": 3},
    {"op": "replace", "path": "/webhooks/2/failurePolicy", "value": "Ignore"},
    {"op": "replace", "path": "/webhooks/2/timeoutSeconds", "value": 3},
    {"op": "replace", "path": "/webhooks/3/failurePolicy", "value": "Ignore"},
    {"op": "replace", "path": "/webhooks/3/timeoutSeconds", "value": 3},
    {"op": "replace", "path": "/webhooks/4/failurePolicy", "value": "Ignore"},
    {"op": "replace", "path": "/webhooks/4/timeoutSeconds", "value": 3}
  ]'

