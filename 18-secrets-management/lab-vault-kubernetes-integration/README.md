# Lab: Vault Kubernetes Integration

Integrate Vault with TaskFlow Kubernetes workloads — K8s authentication, Vault Agent sidecar injection, and CSI secrets provider.

## What you build

- Kubernetes auth method configuration and roles
- TaskFlow API deployment with Vault Agent injector annotations
- `SecretProviderClass` for CSI-mounted secrets
- ServiceAccount and RBAC for Vault auth

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
kubectl apply -f deliverables/k8s/
# See deliverables/VAULT_KUBERNETES_GUIDE.md
```