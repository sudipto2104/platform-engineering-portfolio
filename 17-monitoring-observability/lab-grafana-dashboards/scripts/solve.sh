#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Grafana Dashboards Lab — Solve ==="
mkdir -p "$DELIV/grafana/dashboards" "$DELIV/grafana/provisioning"
cp "$SRC/GRAFANA_DASHBOARDS_GUIDE.md" "$DELIV/"
cp "$SRC/grafana/dashboards/"*.json "$DELIV/grafana/dashboards/"
cp "$SRC/grafana/provisioning/"*.yaml "$DELIV/grafana/provisioning/"

echo "→ deliverables/grafana/"
echo "Run ./scripts/check.sh"