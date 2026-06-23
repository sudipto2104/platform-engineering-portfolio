#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== GitOps Production Patterns Lab — Solve ==="
mkdir -p "$DELIV"/{rollouts,policies,argocd/applicationsets,argocd/notifications,disaster-recovery}
cp "$SRC/GITOPS_PRODUCTION_GUIDE.md" "$DELIV/"
cp "$SRC/rollouts/"*.yaml "$DELIV/rollouts/"
cp "$SRC/policies/"*.yaml "$DELIV/policies/"
cp "$SRC/argocd/applicationsets/"*.yaml "$DELIV/argocd/applicationsets/"
cp "$SRC/argocd/notifications/"*.yaml "$DELIV/argocd/notifications/"
cp "$SRC/disaster-recovery/"* "$DELIV/disaster-recovery/"

echo "→ deliverables/rollouts/, policies/, argocd/, disaster-recovery/"
echo "Run ./scripts/check.sh"