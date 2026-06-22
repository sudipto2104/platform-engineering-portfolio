#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SITE="$DELIV/playbooks/site.yml"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Ansible Roles Lab — Check ==="

for role in common nginx postgresql redis; do
  [[ -f "$DELIV/roles/$role/tasks/main.yml" ]] && pass "$role role" || fail "$role role"
done

[[ -f "$DELIV/roles/nginx/handlers/main.yml" ]] && pass "nginx handlers" || fail "nginx handlers"
[[ -f "$DELIV/roles/nginx/meta/main.yml" ]] && pass "role dependencies" || fail "dependencies"
grep -q 'dependencies' "$DELIV/roles/nginx/meta/main.yml" && pass "meta dependencies" || fail "meta deps"

[[ -f "$DELIV/requirements.yml" ]] && pass "requirements.yml" || fail "requirements.yml"
grep -q 'geerlingguy.docker' "$DELIV/requirements.yml" && pass "Galaxy role" || fail "Galaxy"
grep -q 'role: nginx' "$SITE" && pass "nginx in site" || fail "nginx wired"
grep -q 'role: postgresql' "$SITE" && pass "postgresql in site" || fail "postgresql wired"
grep -q 'role: redis' "$SITE" && pass "redis in site" || fail "redis wired"
grep -qiE 'ansible-galaxy|role' "$DELIV/ANSIBLE_ROLES_GUIDE.md" && pass "Roles guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }