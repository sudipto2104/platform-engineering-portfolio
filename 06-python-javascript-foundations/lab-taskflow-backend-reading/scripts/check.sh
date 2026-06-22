#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
API="$LAB_DIR/workspace/taskflow-api"
DELIV="$LAB_DIR/deliverables/BACKEND_READING_NOTES.md"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== TaskFlow Backend Reading Lab — Check ==="

[[ -f "$API/app/main.py" ]] && pass "main.py" || fail "main.py"
[[ -f "$API/app/routes/tasks.py" ]] && pass "tasks routes" || fail "tasks routes"
[[ -f "$API/app/models/task.py" ]] && pass "Task model" || fail "Task model"
[[ -f "$API/app/services/task_service.py" ]] && pass "TaskService" || fail "TaskService"
[[ -f "$API/app/schemas/task.py" ]] && pass "Pydantic schemas" || fail "schemas"

[[ -f "$DELIV" ]] && pass "Reading notes" || fail "Reading notes"
grep -qiE 'create_app|startup' "$DELIV" && pass "Startup documented" || fail "Startup"
grep -qiE 'route|/api/tasks|blueprint' "$DELIV" && pass "Routes documented" || fail "Routes"
grep -qiE 'model|Task' "$DELIV" && pass "Models documented" || fail "Models"
grep -qiE 'service|TaskService' "$DELIV" && pass "Service layer" || fail "Service layer"
grep -qiE 'schema|pydantic|validation' "$DELIV" && pass "Schemas documented" || fail "Schemas"
grep -qiE 'docker|8080|health' "$DELIV" && pass "Docker prep notes" || fail "Docker prep"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }