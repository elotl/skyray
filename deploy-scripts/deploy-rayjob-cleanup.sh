kubectl apply -f https://raw.githubusercontent.com/ray-project/kuberay/v1.1.0-rc.0/ray-operator/config/samples/ray-job.shutdown.yaml
kubectl label rayjob.ray.io/rayjob-sample-shutdown app.kubernetes.io/instance=rayjob
kubectl label cm ray-job-code-sample app.kubernetes.io/instance=rayjob

