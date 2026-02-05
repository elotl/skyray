helm uninstall nim-operator $1
#
kubectl delete crd nemocustomizers.apps.nvidia.com
kubectl delete crd nemodatastores.apps.nvidia.com
kubectl delete crd nemoentitystores.apps.nvidia.com
kubectl delete crd nemoevaluators.apps.nvidia.com
kubectl delete crd nemoguardrails.apps.nvidia.com
kubectl delete crd nimbuilds.apps.nvidia.com
kubectl delete crd nimcaches.apps.nvidia.com
kubectl delete crd nimpipelines.apps.nvidia.com
kubectl delete crd nimservices.apps.nvidia.com
