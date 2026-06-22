#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== K8s Backend Deployment Lab — Solve ==="
mkdir -p "$DELIV"
cp "$LAB_DIR/solutions/"*.yaml "$LAB_DIR/solutions/KUBECTL_GUIDE.md" "$DELIV/"

if command -v kubectl &>/dev/null; then
  kubectl apply --dry-run=client -f "$DELIV/" 2>&1 | tail -3 || true
  echo "  kubectl dry-run OK"
fi

echo "→ deliverables/*.yaml"
echo "Run ./scripts/check.sh"