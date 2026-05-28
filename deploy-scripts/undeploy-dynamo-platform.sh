helm uninstall dynamo-platform $1

kubectl delete crd dynamocheckpoints.nvidia.com                  
kubectl delete crd dynamocomponentdeployments.nvidia.com        
kubectl delete crd dynamographdeploymentrequests.nvidia.com    
kubectl delete crd dynamographdeployments.nvidia.com          
kubectl delete crd dynamographdeploymentscalingadapters.nvidia.com
kubectl delete crd dynamomodels.nvidia.com                       
kubectl delete crd dynamoworkermetadatas.nvidia.com             
