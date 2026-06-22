# RBAC & Security Guide

## Namespace isolation

| Namespace | PSS enforce | Purpose |
|-----------|-------------|---------|
| taskflow-dev | baseline | Developer sandboxes |
| taskflow-staging | baseline | Pre-prod validation |
| taskflow-prod | restricted | Production workloads |

## RBAC principles

- **Role** scoped to single namespace
- **RoleBinding** ties ServiceAccount → Role
- No cluster-admin for app teams; use `resourceNames` for single ConfigMap access

## Verify

```bash
kubectl auth can-i create deployments --as=system:serviceaccount:taskflow-staging:taskflow-deployer -n taskflow-staging
kubectl auth can-i create deployments --as=system:serviceaccount:taskflow-dev:taskflow-readonly -n taskflow-dev
kubectl describe networkpolicy -n taskflow-prod
```

## NetworkPolicy

Default-deny ingress, explicit allow paths for UI→API and API→data tier.