#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Prometheus Metrics Collection Lab — Solve ==="
mkdir -p "$DELIV"/{prometheus,exporters,promql,k8s}
cp "$SRC/PROMETHEUS_GUIDE.md" "$SRC/requirements.txt" "$DELIV/"
cp "$SRC/prometheus/"*.yml "$DELIV/prometheus/"
cp "$SRC/exporters/"*.py "$DELIV/exporters/"
cp "$SRC/promql/"*.md "$DELIV/promql/"
cp "$SRC/k8s/"*.yaml "$DELIV/k8s/"

if command -v python3 &>/dev/null; then
  python3 -m py_compile "$DELIV"/exporters/*.py 2>&1 | tail -1 || true
fi

echo "→ deliverables/prometheus/, exporters/, k8s/"
echo "Run ./scripts/check.sh"