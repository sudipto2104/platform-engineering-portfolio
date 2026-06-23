#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Kustomize ArgoCD Multi-Env Lab — Solve ==="
mkdir -p "$DELIV/kustomize/base" "$DELIV/kustomize/overlays"/{dev,staging,production} "$DELIV/argocd/applications"
cp "$SRC/KUSTOMIZE_ARGOCD_GUIDE.md" "$DELIV/"
cp -R "$SRC/kustomize/base/." "$DELIV/kustomize/base/"
for env in dev staging production; do
  cp -R "$SRC/kustomize/overlays/$env/." "$DELIV/kustomize/overlays/$env/"
done
cp "$SRC/argocd/applications/"*.yaml "$DELIV/argocd/applications/"

echo "→ deliverables/kustomize/, argocd/applications/"
echo "Run ./scripts/check.sh"