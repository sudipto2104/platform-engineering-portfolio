#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== FastAPI Async & Testing Lab — Solve ==="
mkdir -p "$DELIV/taskflow_platform_api"/{routers,tasks,tests}
cp "$SRC/ASYNC_TESTING_GUIDE.md" "$SRC/requirements.txt" "$SRC/pytest.ini" "$DELIV/"
cp "$SRC/taskflow_platform_api/"*.py "$DELIV/taskflow_platform_api/"
cp "$SRC/taskflow_platform_api/routers/"*.py "$DELIV/taskflow_platform_api/routers/"
cp "$SRC/taskflow_platform_api/tasks/"*.py "$DELIV/taskflow_platform_api/tasks/"
cp "$SRC/taskflow_platform_api/tests/"*.py "$DELIV/taskflow_platform_api/tests/"

if command -v python3 &>/dev/null; then
  python3 -m py_compile "$DELIV"/taskflow_platform_api/*.py \
    "$DELIV"/taskflow_platform_api/routers/*.py \
    "$DELIV"/taskflow_platform_api/tasks/*.py \
    "$DELIV"/taskflow_platform_api/tests/*.py 2>&1 | tail -1 || true
fi

echo "→ deliverables/taskflow_platform_api/"
echo "Run ./scripts/check.sh"