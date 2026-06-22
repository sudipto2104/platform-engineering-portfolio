#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TASKFLOW_DIR="$(cd "$LAB_DIR/../taskflow" && pwd)"

echo "=== Platform Automation Lab — Solve ==="

mkdir -p "$LAB_DIR/deliverables" "$LAB_DIR/automation"

for f in WORKFLOW_ANALYSIS.md AUTOMATION_DECISIONS.md; do
  cp "$LAB_DIR/solutions/$f" "$LAB_DIR/deliverables/$f"
  echo "→ deliverables/$f"
done

for script in taskflow-setup.sh taskflow-health.sh taskflow-smoke.sh; do
  cp "$LAB_DIR/solutions/automation/$script" "$LAB_DIR/automation/$script"
  chmod +x "$LAB_DIR/automation/$script"
  echo "→ automation/$script"
done

export TASKFLOW_DIR

echo
echo "→ Running taskflow-setup.sh"
"$LAB_DIR/automation/taskflow-setup.sh"

echo
echo "→ Starting TaskFlow for smoke/health (background)"
source "$TASKFLOW_DIR/.venv/bin/activate"
PORT=18080 TASKFLOW_VERSION=week1-automation python "$TASKFLOW_DIR/app.py" &>/tmp/taskflow-automation/app.log &
APP_PID=$!
sleep 2

export TASKFLOW_BASE_URL="http://localhost:18080"
if "$LAB_DIR/automation/taskflow-health.sh"; then
  echo "  health check passed"
else
  echo "  health check failed"
fi

if "$LAB_DIR/automation/taskflow-smoke.sh"; then
  echo "  smoke tests passed"
else
  echo "  smoke tests failed"
fi

kill "$APP_PID" 2>/dev/null || true

echo
echo "Run ./scripts/check.sh to verify deliverables and scripts."