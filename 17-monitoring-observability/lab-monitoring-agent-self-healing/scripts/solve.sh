#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Monitoring Agent Self-Healing Lab — Solve ==="
mkdir -p "$DELIV/taskflow_monitor_agent" "$DELIV/k8s"
cp "$SRC/MONITORING_AGENT_GUIDE.md" "$SRC/requirements.txt" "$DELIV/"
cp "$SRC/taskflow_monitor_agent/"*.py "$DELIV/taskflow_monitor_agent/"
cp "$SRC/k8s/"*.yaml "$DELIV/k8s/"

if command -v python3 &>/dev/null; then
  python3 -m py_compile "$DELIV"/taskflow_monitor_agent/*.py 2>&1 | tail -1 || true
fi

echo "→ deliverables/taskflow_monitor_agent/"
echo "Run ./scripts/check.sh"