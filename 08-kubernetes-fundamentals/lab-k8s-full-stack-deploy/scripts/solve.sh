#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== K8s Full Stack Deploy Lab — Solve ==="
mkdir -p "$DELIV"
cp "$LAB_DIR/solutions/"*.yaml "$LAB_DIR/solutions/KUBECTL_RUNBOOK.md" "$DELIV/"

if command -v kubectl &>/dev/null; then
  kubectl apply --dry-run=client -f "$DELIV/" 2>&1 | tail -3 || true
fi

echo "→ deliverables/00-*.yaml … 06-frontend.yaml"
echo "Run ./scripts/check.sh"