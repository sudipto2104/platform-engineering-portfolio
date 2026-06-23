#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Vault Fundamentals Lab — Check ==="

[[ -f "$DELIV/vault/helm-values.yaml" ]] && pass "Helm values" || fail "Helm values"
[[ -f "$DELIV/vault/namespace.yaml" ]] && pass "Vault namespace" || fail "Vault namespace"
[[ -f "$DELIV/policies/taskflow-app.hcl" ]] && pass "App policy" || fail "App policy"
[[ -f "$DELIV/policies/taskflow-admin.hcl" ]] && pass "Admin policy" || fail "Admin policy"
[[ -f "$DELIV/scripts/setup-vault.sh" ]] && pass "Setup script" || fail "Setup script"

grep -q 'server:' "$DELIV/vault/helm-values.yaml" && pass "Vault server config" || fail "Vault server config"
grep -q 'userpass\|auth' "$DELIV/scripts/setup-vault.sh" && pass "Auth methods" || fail "Auth methods"
grep -q 'kv\|secrets enable' "$DELIV/scripts/setup-vault.sh" && pass "Secret engine" || fail "Secret engine"
grep -q 'policy write\|taskflow' "$DELIV/scripts/setup-vault.sh" && pass "Policy setup" || fail "Policy setup"
grep -q 'path "secret' "$DELIV/policies/taskflow-app.hcl" && pass "KV path policy" || fail "KV path policy"
grep -qiE 'vault|authentication|policy' "$DELIV/VAULT_FUNDAMENTALS_GUIDE.md" && pass "Vault guide" || fail "Vault guide"
grep -qiE 'secret engine|kv' "$DELIV/VAULT_FUNDAMENTALS_GUIDE.md" && pass "Engines guide" || fail "Engines guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }