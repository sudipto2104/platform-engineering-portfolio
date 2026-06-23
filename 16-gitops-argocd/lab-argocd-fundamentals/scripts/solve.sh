#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== ArgoCD Fundamentals Lab — Solve ==="
mkdir -p "$DELIV/argocd" "$DELIV/manifests"
cp "$SRC/ARGOCD_FUNDAMENTALS_GUIDE.md" "$DELIV/"
cp "$SRC/argocd/"*.yaml "$DELIV/argocd/"
cp "$SRC/manifests/"*.yaml "$DELIV/manifests/"

echo "→ deliverables/argocd/, manifests/"
echo "Run ./scripts/check.sh"