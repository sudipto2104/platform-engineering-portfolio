#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== Helm Multi-Environment Lab — Solve ==="
mkdir -p "$DELIV/charts"
cp -R "$LAB_DIR/solutions/charts/taskflow" "$DELIV/charts/"
cp "$LAB_DIR/solutions/values-"*.yaml "$DELIV/"
cp "$LAB_DIR/solutions/HELM_GUIDE.md" "$DELIV/"

for env in dev staging production; do
  if command -v helm &>/dev/null; then
    helm template "taskflow-$env" "$DELIV/charts/taskflow" \
      -f "$DELIV/values-${env}.yaml" \
      > "$DELIV/rendered-${env}.yaml" 2>/dev/null || true
  fi
done

echo "→ deliverables/charts/taskflow + values-*.yaml"
echo "Run ./scripts/check.sh"