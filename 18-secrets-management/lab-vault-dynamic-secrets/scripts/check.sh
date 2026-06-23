#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Vault Dynamic Secrets Lab — Check ==="

[[ -f "$DELIV/vault/database-engine-config.json" ]] && pass "Database engine config" || fail "Database engine config"
[[ -f "$DELIV/policies/taskflow-db-dynamic.hcl" ]] && pass "Dynamic DB policy" || fail "Dynamic DB policy"
[[ -f "$DELIV/policies/taskflow-compliance.hcl" ]] && pass "Compliance policy" || fail "Compliance policy"
[[ -f "$DELIV/scripts/setup-database-engine.sh" ]] && pass "Setup script" || fail "Setup script"
[[ -f "$DELIV/scripts/rotate-credentials.sh" ]] && pass "Rotation script" || fail "Rotation script"
[[ -f "$DELIV/k8s/taskflow-api-dynamic-db.yaml" ]] && pass "Dynamic DB deployment" || fail "Dynamic DB deployment"

grep -q 'database/config\|secrets enable database' "$DELIV/scripts/setup-database-engine.sh" && pass "Database engine" || fail "Database engine"
grep -q 'database/roles\|default_ttl\|max_ttl' "$DELIV/scripts/setup-database-engine.sh" && pass "Credential roles" || fail "Credential roles"
grep -q 'lease\|revoke\|rotate' "$DELIV/scripts/rotate-credentials.sh" && pass "Lease management" || fail "Lease management"
grep -q 'database/creds' "$DELIV/policies/taskflow-db-dynamic.hcl" && pass "Dynamic creds path" || fail "Dynamic creds path"
grep -q 'audit\|sys/audit' "$DELIV/policies/taskflow-compliance.hcl" && pass "Compliance controls" || fail "Compliance controls"
grep -q 'database/creds/taskflow-app' "$DELIV/k8s/taskflow-api-dynamic-db.yaml" && pass "Dynamic creds in pod" || fail "Dynamic creds in pod"
grep -qiE 'dynamic|rotation|lease' "$DELIV/VAULT_DYNAMIC_SECRETS_GUIDE.md" && pass "Dynamic secrets guide" || fail "Dynamic secrets guide"
grep -qiE 'compliance|ttl|credential' "$DELIV/VAULT_DYNAMIC_SECRETS_GUIDE.md" && pass "Compliance guide" || fail "Compliance guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }