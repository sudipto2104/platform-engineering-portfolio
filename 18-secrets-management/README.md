# Week 18: Secrets Management with HashiCorp Vault

**Slug:** `secrets-management-vault`

Secure TaskFlow with HashiCorp Vault — fundamentals, Kubernetes integration, and dynamic database credentials with automatic rotation.

Builds on [`../08-kubernetes-fundamentals/`](../08-kubernetes-fundamentals/) (K8s Secrets), [`../16-gitops-argocd/`](../16-gitops-argocd/) (GitOps deploys), and [`../17-monitoring-observability/`](../17-monitoring-observability/) (monitoring stack).

## Labs

| Directory | Focus |
|-----------|--------|
| [`lab-vault-fundamentals/`](./lab-vault-fundamentals/) | Vault install, auth methods, KV engine, access policies |
| [`lab-vault-kubernetes-integration/`](./lab-vault-kubernetes-integration/) | K8s auth, Vault Agent injector, CSI secrets provider |
| [`lab-vault-dynamic-secrets/`](./lab-vault-dynamic-secrets/) | Dynamic DB credentials, lease management, rotation, compliance |

Each lab includes `scripts/check.sh` and `scripts/solve.sh`.

## Quick start

```bash
cd lab-vault-fundamentals && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-vault-kubernetes-integration && ./scripts/solve.sh && ./scripts/check.sh
cd ../lab-vault-dynamic-secrets && ./scripts/solve.sh && ./scripts/check.sh
```

## Prerequisites

- Kubernetes cluster (Minikube from Week 8)
- `kubectl` and `helm` installed
- Vault CLI (`brew install vault` or download from hashicorp.com)

## Status

Week 18 complete — 3 Vault secrets management labs, TaskFlow secure platform.