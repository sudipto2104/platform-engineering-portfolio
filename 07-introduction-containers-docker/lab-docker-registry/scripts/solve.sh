#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== Docker Registry Lab — Solve ==="
mkdir -p "$DELIV"

cp "$LAB_DIR/solutions/"{tag-images.sh,push-images.sh,pull-images.sh,REGISTRY_GUIDE.md,docker-compose.registry.yml} "$DELIV/"
cp "$LAB_DIR/config/registry.env" "$DELIV/"
chmod +x "$DELIV/"*.sh

# Generate mock manifest without requiring images
{
  echo "# Registry manifest"
  echo "- namespace: taskflow-lab"
  echo "- api: taskflow-api:v1.0.0"
  echo "- ui: taskflow-ui:v1.0.0"
} > "$DELIV/REGISTRY_MANIFEST.md"

echo "→ deliverables/tag-images.sh, push-images.sh, pull-images.sh"
echo "Run ./scripts/check.sh"