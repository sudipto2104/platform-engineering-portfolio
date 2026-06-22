#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
UI="$LAB_DIR/workspace/taskflow-ui"
DELIV="$LAB_DIR/deliverables/FRONTEND_READING_NOTES.md"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Vue Frontend Reading Lab — Check ==="

[[ -f "$UI/src/main.js" ]] && pass "main.js bootstrap" || fail "main.js"
[[ -f "$UI/src/components/TaskList.vue" ]] && pass "TaskList component" || fail "TaskList"
[[ -f "$UI/src/stores/taskStore.js" ]] && pass "Pinia store" || fail "Pinia store"
[[ -f "$UI/src/router/index.js" ]] && pass "Vue Router" || fail "Router"
[[ -f "$UI/src/api/taskflow.js" ]] && pass "API client" || fail "API client"

[[ -f "$DELIV" ]] && pass "Reading notes" || fail "Reading notes"
grep -qiE 'pinia|createApp|main\.js' "$DELIV" && pass "Bootstrap documented" || fail "Bootstrap"
grep -qiE 'component|TaskCard|TaskList' "$DELIV" && pass "Components documented" || fail "Components"
grep -qiE 'store|fetchTasks' "$DELIV" && pass "State management" || fail "State"
grep -qiE 'router|route|Dashboard' "$DELIV" && pass "Routing documented" || fail "Routing"
grep -qiE 'api|axios|VITE_API' "$DELIV" && pass "API integration" || fail "API"
grep -qiE 'docker|vite|build|dist' "$DELIV" && pass "Container prep notes" || fail "Container prep"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }