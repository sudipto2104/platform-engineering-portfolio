#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Backstage Software Templates Lab — Solve ==="
mkdir -p "$DELIV/templates/fastapi-microservice/skeleton/"{src,.github/workflows}
cp "$SRC/SOFTWARE_TEMPLATES_GUIDE.md" "$SRC/app-config.auth-rbac.yaml" "$DELIV/"
cp "$SRC/templates/fastapi-microservice/template.yaml" "$DELIV/templates/fastapi-microservice/"
cp -a "$SRC/templates/fastapi-microservice/skeleton/." "$DELIV/templates/fastapi-microservice/skeleton/"

echo "→ deliverables/templates/fastapi-microservice/"
echo "Run ./scripts/check.sh"