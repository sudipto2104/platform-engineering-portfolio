#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== IDP Strategy Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables"

for f in DEVELOPER_EXPERIENCE_ASSESSMENT.md PLATFORM_CAPABILITIES.md TEAM_STRUCTURE.md PLATFORM_ROADMAP.md; do
  cp "$LAB_DIR/solutions/$f" "$LAB_DIR/deliverables/$f"
  echo "→ deliverables/$f"
done

echo
echo "Customize deliverables/ in your own words. Run ./scripts/check.sh"