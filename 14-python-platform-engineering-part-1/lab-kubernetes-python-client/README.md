# Lab: Kubernetes Python Client

Programmatically manage TaskFlow workloads on Kubernetes using the official Python client library.

## What you build

- `taskflow_k8s/` package for pods, deployments, and services
- `workflow.py` — end-to-end deploy/status/teardown automation
- Reference manifests aligned with Week 8 TaskFlow stack

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
pip install -r deliverables/requirements.txt
python -m taskflow_k8s status --namespace taskflow
```

Requires `kubectl` context (Minikube from Week 8) or `KUBECONFIG` env var.