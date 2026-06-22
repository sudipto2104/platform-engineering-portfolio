#!/usr/bin/env bash
# Copy reference vision documents to project root.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== TaskFlow Vision Project — Solve ==="
echo

for f in VISION.md FEATURES.md USER_STORIES.md SUCCESS_METRICS.md; do
  cp "$PROJECT_DIR/examples/$f" "$PROJECT_DIR/$f"
  echo "→ Copied examples/$f → $f"
done

echo
echo "Customize these documents to reflect your own TaskFlow vision."
echo "Run ./scripts/check.sh to verify."