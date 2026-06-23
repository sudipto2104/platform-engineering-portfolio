#!/usr/bin/env bash
# Configure Vault Kubernetes authentication for TaskFlow workloads
set -euo pipefail

export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
export VAULT_TOKEN="${VAULT_TOKEN:-taskflow-dev-root}"

K8S_HOST="${K8S_HOST:-https://kubernetes.default.svc}"
SA_JWT="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token 2>/dev/null || echo 'REPLACE_WITH_SA_JWT')"
SA_CA_CERT="${SA_CA_CERT:-/var/run/secrets/kubernetes.io/serviceaccount/ca.crt}"

echo "=== Configure Vault Kubernetes Auth ==="

vault auth enable kubernetes 2>/dev/null || echo "kubernetes auth already enabled"

vault write auth/kubernetes/config \
  kubernetes_host="$K8S_HOST" \
  kubernetes_ca_cert=@"${SA_CA_CERT}" \
  token_reviewer_jwt="$SA_JWT"

vault write auth/kubernetes/role/taskflow-api \
  bound_service_account_names=taskflow-api \
  bound_service_account_namespaces=taskflow,taskflow-production \
  policies=taskflow-app \
  ttl=1h \
  max_ttl=4h

vault write auth/kubernetes/role/taskflow-csi \
  bound_service_account_names=taskflow-api \
  bound_service_account_namespaces=taskflow \
  policies=taskflow-app \
  ttl=30m

echo "Kubernetes auth configured for TaskFlow service accounts."