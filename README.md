# skyray
Support interoperation of KubeRay with Nova and Luna

# KServe

## Nova + KServe Quick Start

Install in this order against the Nova control plane:

### 1. Prerequisites

- **Nova** control plane and workload clusters must be set up and running
- **cert-manager** must be installed on the workload clusters (required by KServe webhooks)

```bash
➜ kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.20.0/cert-manager.yaml
```

### 2. Apply Nova Spread Policies

These tell Nova to duplicate KServe CRDs, namespace, and operator components to all workload clusters:

```bash
kubectl apply -f policies/kservecrdpolicy.yaml
kubectl apply -f policies/kservenspolicy.yaml
kubectl apply -f policies/kservepolicy.yaml
```

### 3. Create the KServe Namespace

```bash
kubectl apply -f deploy-scripts/kservenamespace.yaml
```

### 4. Deploy KServe (CRDs + Operator)

```bash
bash deploy-scripts/deploy-kserve.sh
```

This installs the `kserve-crd` and `kserve` helm charts, then labels CRDs and operator resources so the spread policies pick them up.

### 5. Apply InferenceService Placement Policy

Choose one of the placement policies for InferenceService CRs:

```bash
# For kind testing (targets kind-workload-2):
kubectl apply -f policies/inferenceservicepolicy.yaml

# Or for namespace-scoped priority placement (also set to kind-workload-2 for testing;
# see commented-out orderedClusterSelector for production onprem→cloud ordering):
# export APP_NAMESPACE=my-app
# envsubst < policies/inferenceservicensprioritypolicy.yaml | kubectl apply -f -
```

### 6. Deploy an InferenceService

```bash
export SKYRAY_PATH=$(pwd)
export APP_NAMESPACE=default
export INFERENCE_SERVICE_NAME=my-model
bash deploy-scripts/deploy-inferenceservice.sh
```

Or apply the sample directly:

```bash
kubectl apply -f deploy-scripts/inference-service.sample.yaml
```

### Teardown

```bash
bash deploy-scripts/undeploy-kserve.sh
```

## Files Reference

| File | Purpose |
|------|---------|
| `deploy-scripts/deploy-kserve.sh` | Install KServe CRDs + operator, label resources for Nova |
| `deploy-scripts/undeploy-kserve.sh` | Uninstall KServe and delete CRDs |
| `deploy-scripts/kservenamespace.yaml` | KServe namespace with `app: kserve` label |
| `deploy-scripts/deploy-inferenceservice.sh` | Deploy and label an InferenceService CR |
| `deploy-scripts/inference-service.sample.yaml` | Sample InferenceService template |
| `policies/kservecrdpolicy.yaml` | Spread KServe CRDs to all clusters |
| `policies/kservenspolicy.yaml` | Spread KServe namespace to all clusters |
| `policies/kservepolicy.yaml` | Spread KServe operator to all clusters |
| `policies/inferenceservicepolicy.yaml` | Place InferenceService on a target cluster |
| `policies/inferenceservicensprioritypolicy.yaml` | Place InferenceService with cluster priority |
