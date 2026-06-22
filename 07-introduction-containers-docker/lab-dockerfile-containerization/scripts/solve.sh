#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
STACK="$(cd "$LAB_DIR/../taskflow-stack" && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== Dockerfile Containerization Lab — Solve ==="
mkdir -p "$DELIV"

cp "$LAB_DIR/solutions/Dockerfile.backend" "$LAB_DIR/solutions/Dockerfile.frontend" \
   "$LAB_DIR/solutions/nginx.conf" "$LAB_DIR/solutions/CONTAINER_GUIDE.md" "$DELIV/"

if command -v docker &>/dev/null && docker info &>/dev/null 2>&1; then
  docker build -f "$DELIV/Dockerfile.backend" -t taskflow-api:week7 "$STACK/backend" 2>&1 | tail -2
  echo "  backend image: taskflow-api:week7"
else
  echo "→ Docker not available — Dockerfiles generated"
fi

echo "Run ./scripts/check.sh"