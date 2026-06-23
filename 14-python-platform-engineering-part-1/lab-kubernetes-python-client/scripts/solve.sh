#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Kubernetes Python Client Lab — Solve ==="
mkdir -p "$DELIV/taskflow_k8s" "$DELIV/manifests"
cp "$SRC/KUBERNETES_PYTHON_GUIDE.md" "$SRC/requirements.txt" "$DELIV/"
cp "$SRC/taskflow_k8s/"*.py "$DELIV/taskflow_k8s/"
cp "$SRC/manifests/"*.yaml "$DELIV/manifests/"

if command -v python3 &>/dev/null; then
  python3 -m py_compile "$DELIV"/taskflow_k8s/*.py 2>&1 | tail -1 || true
fi

echo "→ deliverables/taskflow_k8s/, manifests/"
echo "Run ./scripts/check.sh"