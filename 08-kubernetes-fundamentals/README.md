# Week 8: Kubernetes Fundamentals

**Slug:** `kubernetes-fundamentals`

Deploy TaskFlow to Kubernetes — backend replicas and services, ConfigMaps/Secrets with stateful data, and a full four-tier stack on Minikube.

## Prerequisites

- Minikube + kubectl
- Week 7 images loaded: `taskflow-api:week7`, `taskflow-ui:week7` (see [`taskflow-k8s/`](./taskflow-k8s/))

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-k8s-backend-deployment/`](./lab-k8s-backend-deployment/) | Minikube, Deployment, ClusterIP, scale & rollouts |
| [`lab-k8s-config-state/`](./lab-k8s-config-state/) | ConfigMaps, Secrets, Postgres StatefulSet, Redis |
| [`lab-k8s-full-stack-deploy/`](./lab-k8s-full-stack-deploy/) | Capstone — namespace, 4 tiers, NodePort, DNS |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-k8s-backend-deployment && ./scripts/solve.sh && ./scripts/check.sh
```

## Status

Week 8 complete — 3 labs, TaskFlow K8s manifests, check/solve scripts.