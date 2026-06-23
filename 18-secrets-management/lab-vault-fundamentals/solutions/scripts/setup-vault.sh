#!/usr/bin/env bash
# Initialize TaskFlow Vault: auth methods, KV engine, policies, sample secrets
set -euo pipefail

export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
export VAULT_TOKEN="${VAULT_TOKEN:-taskflow-dev-root}"

echo "=== TaskFlow Vault Setup ==="

# Enable KV v2 secrets engine at secret/
vault secrets enable -path=secret kv-v2 2>/dev/null || echo "KV engine already enabled"

# Enable userpass auth
vault auth enable userpass 2>/dev/null || echo "userpass auth already enabled"

# Write policies
vault policy write taskflow-app policies/taskflow-app.hcl
vault policy write taskflow-admin policies/taskflow-admin.hcl

# Create application user
vault write auth/userpass/users/taskflow-app \
  password="${TASKFLOW_APP_PASSWORD:-taskflow-app-secret}" \
  policies=taskflow-app

# Seed TaskFlow application secrets
vault kv put secret/taskflow/app/config \
  api_key="tf-api-$(openssl rand -hex 8)" \
  jwt_secret="$(openssl rand -hex 16)" \
  environment="dev"

vault kv put secret/taskflow/app/database \
  host="postgres.taskflow.svc" \
  port="5432" \
  database="taskflow" \
  username="taskflow"

echo "Vault setup complete."
echo "  UI:      $VAULT_ADDR/ui"
echo "  Login:   userpass/taskflow-app"
echo "  Read:    vault kv get secret/taskflow/app/config"