#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PLUGIN="$LAB_DIR/deliverables/plugins/taskflow-dashboard"
PAGE="$PLUGIN/src/components/TaskFlowDashboardPage.tsx"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== TaskFlow Dashboard Plugin Lab — Check ==="

[[ -f "$PLUGIN/package.json" ]] && pass "package.json" || fail "package.json"
[[ -f "$PLUGIN/src/plugin.ts" ]] && pass "plugin.ts" || fail "plugin.ts"
[[ -f "$PLUGIN/src/routes.ts" ]] && pass "routes.ts" || fail "routes.ts"
[[ -f "$PAGE" ]] && pass "TaskFlowDashboardPage.tsx" || fail "Dashboard page"
[[ -f "$PLUGIN/src/api/taskflowApi.ts" ]] && pass "taskflowApi.ts" || fail "API client"

grep -q 'useState' "$PAGE" && pass "useState hook" || fail "useState hook"
grep -q 'useEffect' "$PAGE" && pass "useEffect hook" || fail "useEffect hook"
grep -q '@material-ui/core' "$PAGE" && pass "Material-UI imports" || fail "Material-UI imports"
grep -q 'Grid' "$PAGE" && pass "Grid layout" || fail "Grid layout"
grep -q 'Card' "$PAGE" && pass "Card component" || fail "Card component"
grep -q 'loading' "$PAGE" && pass "Loading state" || fail "Loading state"
grep -q 'error' "$PAGE" && pass "Error state" || fail "Error state"
grep -q 'taskCount\|task_count\|tasks' "$PAGE" && pass "Task metrics" || fail "Task metrics"
grep -q 'createPlugin' "$PLUGIN/src/plugin.ts" && pass "createPlugin" || fail "createPlugin"
grep -q 'taskflow-dashboard' "$PLUGIN/src/routes.ts" && pass "Route path" || fail "Route path"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }