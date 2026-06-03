# Note: could have Nova policy w/overrides patch webhook settings back to original values in the target cluster(s)

helm fetch https://helm.ngc.nvidia.com/nvidia/ai-dynamo/charts/dynamo-platform-${RELEASE_VERSION}.tgz
helm install dynamo-platform dynamo-platform-${RELEASE_VERSION}.tgz \
 --set dynamo-operator.webhook.failurePolicy="Ignore" --set dynamo-operator.webhook.timeoutSeconds=3 $1

kubectl label crd dynamocheckpoints.nvidia.com                    app.kubernetes.io/component=dynamo-platform
kubectl label crd dynamocomponentdeployments.nvidia.com           app.kubernetes.io/component=dynamo-platform
kubectl label crd dynamographdeploymentrequests.nvidia.com        app.kubernetes.io/component=dynamo-platform
kubectl label crd dynamographdeployments.nvidia.com               app.kubernetes.io/component=dynamo-platform
kubectl label crd dynamographdeploymentscalingadapters.nvidia.com app.kubernetes.io/component=dynamo-platform
kubectl label crd dynamomodels.nvidia.com                         app.kubernetes.io/component=dynamo-platform
kubectl label crd dynamoworkermetadatas.nvidia.com                app.kubernetes.io/component=dynamo-platform
