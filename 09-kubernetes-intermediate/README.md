# Week 9: Kubernetes Intermediate — Production Deployments

**Slug:** `kubernetes-intermediate`

Production TaskFlow on Kubernetes — Helm multi-env charts, Ingress + TLS + HPA, and RBAC with namespace isolation.

Builds on [`../08-kubernetes-fundamentals/`](../08-kubernetes-fundamentals/).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-helm-multi-environment/`](./lab-helm-multi-environment/) | Helm 3 charts — dev, staging, production values |
| [`lab-ingress-tls-autoscaling/`](./lab-ingress-tls-autoscaling/) | Nginx Ingress 1.12+, TLS, HorizontalPodAutoscaler |
| [`lab-rbac-namespace-security/`](./lab-rbac-namespace-security/) | Namespaces, RBAC, NetworkPolicy, pod security |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-helm-multi-environment && ./scripts/solve.sh && ./scripts/check.sh
```

## Status

Week 9 complete — 3 labs, Helm chart, Ingress/HPA, security manifests.