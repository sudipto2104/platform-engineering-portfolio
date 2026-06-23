# Week 14: Python for Platform Engineering — Part 1

**Slug:** `python-platform-engineering-part-1`

Automate TaskFlow platform operations with production-ready Python — AWS via Boto3, Kubernetes via the official client, and self-service CLI tools with Click and Typer.

Builds on [`../10-introduction-cloud-computing/`](../10-introduction-cloud-computing/) (AWS), [`../08-kubernetes-fundamentals/`](../08-kubernetes-fundamentals/) (K8s manifests), and [`../06-python-javascript-foundations/`](../06-python-javascript-foundations/) (Python basics).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-boto3-aws-automation/`](./lab-boto3-aws-automation/) | Boto3 — EC2, S3, CloudWatch, Lambda automation |
| [`lab-kubernetes-python-client/`](./lab-kubernetes-python-client/) | Kubernetes Python client — pods, deployments, services, workflows |
| [`lab-cli-tools-click-typer/`](./lab-cli-tools-click-typer/) | Click & Typer CLI tools for DevOps self-service |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-boto3-aws-automation && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-kubernetes-python-client && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-cli-tools-click-typer && ./scripts/solve.sh && ./scripts/check.sh
```

## Prerequisites

- Python 3.11+
- AWS credentials (for Boto3 lab — `aws configure` or env vars)
- `kubectl` + cluster access (for Kubernetes lab — Minikube from Week 8)
- Optional: `pip install -r deliverables/requirements.txt` per lab

## Status

Week 14 complete — 3 Python platform engineering labs, TaskFlow automation toolkit.