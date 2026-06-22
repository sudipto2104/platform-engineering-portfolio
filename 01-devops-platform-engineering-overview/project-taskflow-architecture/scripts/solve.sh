#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== TaskFlow Architecture Project — Solve ==="
mkdir -p "$PROJECT_DIR/deliverables"

for f in TECHNOLOGY_DECISIONS.md SYSTEM_ARCHITECTURE.md COMPONENT_INTERACTIONS.md; do
  cp "$PROJECT_DIR/examples/$f" "$PROJECT_DIR/deliverables/$f"
  echo "→ deliverables/$f"
done

echo
echo "Refine the architecture for your portfolio. Run ./scripts/check.sh"