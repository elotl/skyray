helm upgrade --install nim-operator nvidia/k8s-nim-operator --version=3.0.2 $1
#
kubectl label crd nemocustomizers.apps.nvidia.com  app.kubernetes.io/component=nim-operator
kubectl label crd nemodatastores.apps.nvidia.com   app.kubernetes.io/component=nim-operator
kubectl label crd nemoentitystores.apps.nvidia.com app.kubernetes.io/component=nim-operator
kubectl label crd nemoevaluators.apps.nvidia.com   app.kubernetes.io/component=nim-operator
kubectl label crd nemoguardrails.apps.nvidia.com   app.kubernetes.io/component=nim-operator
kubectl label crd nimbuilds.apps.nvidia.com        app.kubernetes.io/component=nim-operator
kubectl label crd nimcaches.apps.nvidia.com        app.kubernetes.io/component=nim-operator
kubectl label crd nimpipelines.apps.nvidia.com     app.kubernetes.io/component=nim-operator
kubectl label crd nimservices.apps.nvidia.com      app.kubernetes.io/component=nim-operator
