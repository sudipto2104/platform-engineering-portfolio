# Lab: Vault Fundamentals

Install HashiCorp Vault, configure authentication methods, enable the KV secrets engine, and implement access policies for TaskFlow.

## What you build

- Vault Helm values and namespace configuration
- Userpass and token auth setup scripts
- KV v2 secrets for TaskFlow API keys and config
- HCL policies: `taskflow-app` and `taskflow-admin`

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
helm repo add hashicorp https://helm.releases.hashicorp.com
helm install vault hashicorp/vault -n vault --create-namespace -f deliverables/vault/helm-values.yaml
# See deliverables/VAULT_FUNDAMENTALS_GUIDE.md
```