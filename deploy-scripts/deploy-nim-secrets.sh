kubectl create secret -n ${APP_NAMESPACE} docker-registry ngc-secret \
 --docker-server=nvcr.io --docker-username='$oauthtoken' --docker-password=${NGC_API_KEY}
kubectl create secret -n ${APP_NAMESPACE} generic ngc-api-secret \
 --from-literal=NGC_API_KEY=${NGC_API_KEY}

kubectl label secret -n ${APP_NAMESPACE} ngc-secret app=secret-${APP_NAMESPACE}
kubectl label secret -n ${APP_NAMESPACE} ngc-api-secret app=secret-${APP_NAMESPACE}

