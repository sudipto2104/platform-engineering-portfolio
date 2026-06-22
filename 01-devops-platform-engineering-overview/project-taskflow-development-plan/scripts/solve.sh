#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== TaskFlow Development Plan — Solve ==="
mkdir -p "$PROJECT_DIR/deliverables"

for f in MVP_DEFINITION.md SPRINT_PLAN.md RISK_REGISTER.md; do
  cp "$PROJECT_DIR/examples/$f" "$PROJECT_DIR/deliverables/$f"
  echo "→ deliverables/$f"
done

echo
echo "Customize for your schedule. Run ./scripts/check.sh"