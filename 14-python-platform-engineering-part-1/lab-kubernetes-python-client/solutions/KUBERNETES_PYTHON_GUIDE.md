# Kubernetes Python Client Guide — TaskFlow

## Overview

Build self-service platform automation with the official `kubernetes` Python client. Manage TaskFlow pods, deployments, and services programmatically — the foundation for internal platform tools.

## Module layout

| Module | Responsibility |
|--------|----------------|
| `client_factory.py` | `load_incluster_config` / `load_kube_config` |
| `pods.py` | List, wait, delete pods |
| `deployments.py` | Status, scale, apply manifests |
| `services.py` | List services, read endpoints |
| `workflow.py` | `deploy_taskflow_stack`, `get_taskflow_stack_status` |

## Setup

```bash
pip install -r requirements.txt
minikube start   # Week 8
kubectl config use-context minikube
```

## Deploy TaskFlow stack

```bash
cd deliverables
python -m taskflow_k8s deploy --namespace taskflow
python -m taskflow_k8s status --namespace taskflow
python -m taskflow_k8s scale 3 --namespace taskflow
```

## Workflow API

```python
from taskflow_k8s.workflow import deploy_taskflow_stack, get_taskflow_stack_status

deploy_taskflow_stack("taskflow")
status = get_taskflow_stack_status("taskflow")
print(status["pods"], status["deployments"], status["services"])
```

## Platform engineering patterns

1. **Idempotent applies** — catch `409 AlreadyExists` on create
2. **Structured errors** — wrap `ApiException` with context
3. **Workflow composition** — chain namespace → deployment → service
4. **Self-service** — expose via CLI (Lab 3) or Backstage template (Week 13)

## Verify

```bash
./scripts/check.sh
python -m py_compile taskflow_k8s/*.py
```