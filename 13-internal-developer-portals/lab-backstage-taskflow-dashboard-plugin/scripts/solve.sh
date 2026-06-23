#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== TaskFlow Dashboard Plugin Lab — Solve ==="
mkdir -p "$DELIV/plugins/taskflow-dashboard/src/"{components,api}
cp "$SRC/TASKFLOW_DASHBOARD_GUIDE.md" "$DELIV/"
cp "$SRC/plugins/taskflow-dashboard/package.json" "$DELIV/plugins/taskflow-dashboard/"
cp "$SRC/plugins/taskflow-dashboard/src/"*.ts "$DELIV/plugins/taskflow-dashboard/src/"
cp "$SRC/plugins/taskflow-dashboard/src/components/"*.tsx "$DELIV/plugins/taskflow-dashboard/src/components/"
cp "$SRC/plugins/taskflow-dashboard/src/api/"*.ts "$DELIV/plugins/taskflow-dashboard/src/api/"
cp "$SRC/app-integration-snippet.tsx" "$DELIV/"

echo "→ deliverables/plugins/taskflow-dashboard/"
echo "Run ./scripts/check.sh"