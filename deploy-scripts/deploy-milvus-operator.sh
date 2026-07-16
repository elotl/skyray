# $1 should be namespace specificiation e.g. "-n milvus-operator"
helm install milvus-operator https://github.com/zilliztech/milvus-operator/releases/download/v1.3.7/milvus-operator-1.3.7.tgz --set enableWebhook=false $1

kubectl label crd                milvusclusters.milvus.io                    app.kubernetes.io/name=milvus-operator
kubectl label crd                milvuses.milvus.io                          app.kubernetes.io/name=milvus-operator
kubectl label crd                milvusupgrades.milvus.io                    app.kubernetes.io/name=milvus-operator
kubectl label clusterrole        milvus-operator-manager-role                app.kubernetes.io/name=milvus-operator
kubectl label clusterrolebinding milvus-operator-manager-rolebinding         app.kubernetes.io/name=milvus-operator
kubectl label role               milvus-operator-leader-election-role        app.kubernetes.io/name=milvus-operator $1
kubectl label rolebinding        milvus-operator-leader-election-rolebinding app.kubernetes.io/name=milvus-operator $1

