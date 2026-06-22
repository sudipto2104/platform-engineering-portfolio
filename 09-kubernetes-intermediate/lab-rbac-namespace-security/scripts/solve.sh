#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== RBAC Namespace Security Lab — Solve ==="
mkdir -p "$DELIV"
cp "$LAB_DIR/solutions/"*.yaml "$LAB_DIR/solutions/SECURITY_GUIDE.md" "$DELIV/"

if command -v kubectl &>/dev/null; then
  kubectl apply --dry-run=client -f "$DELIV/namespaces.yaml" -f "$DELIV/rbac.yaml" 2>&1 | tail -2 || true
fi

echo "→ deliverables/namespaces.yaml, rbac.yaml, network-policy.yaml"
echo "Run ./scripts/check.sh"