#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
DEPLOY="$DELIV/playbooks/deploy.yml"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Multi-Environment Ansible Lab — Check ==="

for env in dev staging production; do
  [[ -f "$DELIV/inventories/$env/hosts.ini" ]] && pass "$env inventory" || fail "$env inventory"
done

[[ -f "$DELIV/group_vars/dev.yml" ]] && pass "dev vars" || fail "dev vars"
[[ -f "$DELIV/group_vars/staging.yml" ]] && pass "staging vars" || fail "staging vars"
[[ -f "$DELIV/group_vars/production.yml" ]] && pass "production vars" || fail "production vars"
[[ -f "$DEPLOY" ]] && pass "deploy.yml" || fail "deploy.yml"

grep -q 'vault/secrets.yml' "$DEPLOY" && pass "Vault vars_files" || fail "Vault vars"
grep -q 'role: nginx' "$DEPLOY" && pass "nginx role" || fail "nginx role"
grep -q 'role: postgresql' "$DEPLOY" && pass "postgresql role" || fail "postgresql role"
grep -q 'role: redis' "$DEPLOY" && pass "redis role" || fail "redis role"
grep -q 'environment in' "$DEPLOY" && pass "env validation" || fail "env validation"

[[ -f "$DELIV/vault/secrets.yml" ]] || [[ -f "$DELIV/vault/secrets.yml.example" ]] \
  && pass "Vault secrets" || fail "Vault secrets"
grep -qiE 'ansible-vault|vault' "$DELIV/MULTIENV_DEPLOY_GUIDE.md" && pass "Vault guide" || fail "Vault guide"
[[ -f "$DELIV/ci/ansible-deploy.yml" ]] && pass "CI workflow" || fail "CI workflow"
grep -q 'ANSIBLE_VAULT_PASSWORD' "$DELIV/ci/ansible-deploy.yml" && pass "CI vault secret" || fail "CI vault"
grep -q 'workflow_dispatch' "$DELIV/ci/ansible-deploy.yml" && pass "CI dispatch" || fail "CI dispatch"
grep -q '10.30.10' "$DELIV/inventories/production/hosts.ini" && pass "Production hosts" || fail "Prod hosts"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }