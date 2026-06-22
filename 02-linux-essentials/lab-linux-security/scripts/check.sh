#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT="$LAB_DIR/workspace/taskflow-server"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Linux Security Lab — Check ==="

[[ -f "$LAB_DIR/deliverables/SECURITY_AUDIT.md" ]] && pass "Security audit" || fail "Security audit"
grep -qiE "permission|group|least" "$LAB_DIR/deliverables/SECURITY_AUDIT.md" 2>/dev/null \
  && pass "Audit covers access control" || fail "Audit content"

[[ -f "$ROOT/config/app.env" ]] && pass "Config file exists" || fail "Config file"
[[ -f "$ROOT/data/tasks.json" ]] && pass "Data file exists" || fail "Data file"

# Permission checks (octal)
perm() { stat -f '%OLp' "$1" 2>/dev/null || stat -c '%a' "$1" 2>/dev/null; }
p_env=$(perm "$ROOT/config/app.env" 2>/dev/null || echo 0)
p_data=$(perm "$ROOT/data/tasks.json" 2>/dev/null || echo 0)

[[ "$p_env" == "640" ]] && pass "config/app.env is 640" || fail "config/app.env perms ($p_env, want 640)"
[[ "$p_data" == "600" ]] && pass "data/tasks.json is 600" || fail "data/tasks.json perms ($p_data, want 600)"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }
echo "Linux security lab complete."