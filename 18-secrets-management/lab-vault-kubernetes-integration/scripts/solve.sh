#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Vault Kubernetes Integration Lab — Solve ==="
mkdir -p "$DELIV"/{vault,k8s/{auth,agent,csi}}
cp "$SRC/VAULT_KUBERNETES_GUIDE.md" "$DELIV/"
cp "$SRC/vault/"* "$DELIV/vault/"
cp "$SRC/k8s/auth/"*.yaml "$DELIV/k8s/auth/"
cp "$SRC/k8s/agent/"*.yaml "$DELIV/k8s/agent/"
cp "$SRC/k8s/csi/"*.yaml "$DELIV/k8s/csi/"
chmod +x "$DELIV/vault/"*.sh 2>/dev/null || true

echo "→ deliverables/k8s/, vault/"
echo "Run ./scripts/check.sh"