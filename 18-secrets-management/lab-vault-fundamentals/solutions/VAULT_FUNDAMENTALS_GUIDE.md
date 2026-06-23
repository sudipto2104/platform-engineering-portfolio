# Vault Fundamentals Guide — TaskFlow

## Install Vault

```bash
helm repo add hashicorp https://helm.releases.hashicorp.com
kubectl apply -f vault/namespace.yaml
helm install vault hashicorp/vault -n vault -f vault/helm-values.yaml
kubectl port-forward -n vault svc/vault 8200:8200
```

Dev mode auto-unseals with root token `taskflow-dev-root`.

## Authentication methods

| Method | Use case |
|--------|----------|
| Token | Bootstrap / admin |
| Userpass | Human operators, lab users |
| Kubernetes | Pod/service auth (Lab 2) |

```bash
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=taskflow-dev-root
./scripts/setup-vault.sh
vault login -method=userpass username=taskflow-app
```

## Secret engines

KV v2 at `secret/` stores TaskFlow config:

```bash
vault kv put secret/taskflow/app/config api_key=my-key environment=dev
vault kv get secret/taskflow/app/config
vault kv metadata get secret/taskflow/app/config  # versioning
```

## Access policies

| Policy | Access |
|--------|--------|
| `taskflow-app` | Read `secret/data/taskflow/app/*` |
| `taskflow-admin` | Full CRUD on `secret/data/taskflow/*` |

Policies use HCL path rules with `capabilities` — least privilege by default.

## Verify

```bash
./scripts/check.sh
vault policy read taskflow-app
```