# Week 16: GitOps with ArgoCD

**Slug:** `gitops-with-argocd`

Implement production-grade GitOps for TaskFlow — ArgoCD fundamentals, Kustomize multi-environment deployments, and advanced patterns including progressive delivery, multi-cluster sync, and policy-as-code.

Builds on [`../08-kubernetes-fundamentals/`](../08-kubernetes-fundamentals/) (TaskFlow K8s manifests), [`../09-kubernetes-intermediate/`](../09-kubernetes-intermediate/) (Helm multi-env), and [`../03-version-control-git-github/`](../03-version-control-git-github/) (Git workflows).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-argocd-fundamentals/`](./lab-argocd-fundamentals/) | ArgoCD install, GitOps principles, Application CRD, sync & auto-healing |
| [`lab-kustomize-argocd-multenv/`](./lab-kustomize-argocd-multenv/) | Kustomize overlays (dev/staging/prod) with ArgoCD Applications |
| [`lab-gitops-production-patterns/`](./lab-gitops-production-patterns/) | Canary, blue-green, rollback, multi-cluster, policy-as-code, DR |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-argocd-fundamentals && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-kustomize-argocd-multenv && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-gitops-production-patterns && ./scripts/solve.sh && ./scripts/check.sh
```

## Prerequisites

- Minikube or Kubernetes cluster (Week 8)
- `kubectl` configured
- GitHub repo access for ArgoCD source configuration

## Status

Week 16 complete — 3 GitOps labs, TaskFlow ArgoCD platform.