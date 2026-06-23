# Vault Kubernetes Integration Guide — TaskFlow

## Kubernetes authentication

Pods authenticate to Vault using their ServiceAccount JWT:

```bash
kubectl apply -f k8s/auth/serviceaccount.yaml
kubectl exec -n vault vault-0 -- sh /path/to/kubernetes-auth-config.sh
```

Role `taskflow-api` binds SA `taskflow-api` in namespace `taskflow` to policy `taskflow-app`.

## Vault Agent sidecar injection

Annotations on the pod template trigger automatic sidecar injection:

| Annotation | Purpose |
|------------|---------|
| `vault.hashicorp.com/agent-inject: "true"` | Enable injector |
| `vault.hashicorp.com/role: "taskflow-api"` | K8s auth role |
| `vault.hashicorp.com/agent-inject-secret-config` | Secret path |
| `agent-inject-template-config` | Consul-template for env vars |

Secrets appear at `/vault/secrets/config` — sourced before app start.

```bash
kubectl apply -f k8s/agent/taskflow-api-vault-agent.yaml
kubectl logs -n taskflow -l app=taskflow-api -c vault-agent
```

## CSI Secrets Store provider

Mount secrets as volumes without sidecar:

```bash
kubectl apply -f k8s/csi/secret-provider-class.yaml
```

`SecretProviderClass` syncs Vault secrets to a native K8s `Secret` (`taskflow-vault-sync`) for `envFrom` injection.

## Comparison

| Approach | Pros | Cons |
|----------|------|------|
| Agent injector | Templates, renewal, init containers | Extra sidecar |
| CSI provider | Native volume mount, K8s Secret sync | CSI driver required |

## Verify

```bash
./scripts/check.sh
kubectl get secretproviderclass -n taskflow
```