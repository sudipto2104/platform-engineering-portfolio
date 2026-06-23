#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== FastAPI Platform API Lab — Solve ==="
mkdir -p "$DELIV/taskflow_platform_api/routers"
cp "$SRC/FASTAPI_PLATFORM_API_GUIDE.md" "$SRC/requirements.txt" "$DELIV/"
cp "$SRC/taskflow_platform_api/"*.py "$DELIV/taskflow_platform_api/"
cp "$SRC/taskflow_platform_api/routers/"*.py "$DELIV/taskflow_platform_api/routers/"

if command -v python3 &>/dev/null; then
  python3 -m py_compile "$DELIV"/taskflow_platform_api/*.py "$DELIV"/taskflow_platform_api/routers/*.py 2>&1 | tail -1 || true
fi

echo "→ deliverables/taskflow_platform_api/"
echo "Run ./scripts/check.sh"