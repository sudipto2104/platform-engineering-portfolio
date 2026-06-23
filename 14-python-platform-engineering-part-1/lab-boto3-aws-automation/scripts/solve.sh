#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Boto3 AWS Automation Lab — Solve ==="
mkdir -p "$DELIV/taskflow_aws"
cp "$SRC/BOTO3_AWS_GUIDE.md" "$SRC/requirements.txt" "$DELIV/"
cp "$SRC/taskflow_aws/"*.py "$DELIV/taskflow_aws/"
cp "$SRC/taskflow_aws/__main__.py" "$DELIV/taskflow_aws/" 2>/dev/null || true

if command -v python3 &>/dev/null; then
  python3 -m py_compile "$DELIV"/taskflow_aws/*.py 2>&1 | tail -1 || true
fi

echo "→ deliverables/taskflow_aws/"
echo "Run ./scripts/check.sh"