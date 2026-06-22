#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
PB="$DELIV/playbooks/taskflow-servers.yml"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Ansible Fundamentals Lab — Check ==="

[[ -f "$DELIV/ansible.cfg" ]] && pass "ansible.cfg" || fail "ansible.cfg"
[[ -f "$DELIV/inventory/hosts.ini" ]] && pass "Inventory" || fail "Inventory"
grep -q 'taskflow_app' "$DELIV/inventory/hosts.ini" && pass "taskflow_app group" || fail "Server group"
[[ -f "$DELIV/inventory/group_vars/all.yml" ]] && pass "group_vars" || fail "group_vars"
[[ -f "$DELIV/playbooks/site.yml" ]] && pass "site.yml" || fail "site.yml"
[[ -f "$PB" ]] && pass "taskflow-servers.yml" || fail "Playbook"

grep -q 'ansible.builtin.yum' "$PB" && pass "yum module" || fail "yum module"
grep -q 'ansible.builtin.copy' "$PB" && pass "copy module" || fail "copy module"
grep -q 'ansible.builtin.template' "$PB" && pass "template module" || fail "template module"
grep -q 'ansible.builtin.service' "$PB" && pass "service module" || fail "service module"
grep -q 'ansible.builtin.user' "$PB" && pass "user module" || fail "user module"
grep -q 'ansible.builtin.file' "$PB" && pass "file module" || fail "file module"
grep -qiE 'idempotenc' "$DELIV/ANSIBLE_FUNDAMENTALS_GUIDE.md" && pass "Idempotency guide" || fail "Idempotency"
grep -qiE 'ansible-playbook|ansible init' "$DELIV/ANSIBLE_FUNDAMENTALS_GUIDE.md" && pass "Workflow guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }