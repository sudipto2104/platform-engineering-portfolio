#!/usr/bin/env bash
# Populate deliverables/ with reference solution for comparison.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== DevOps Analysis Lab — Solve ==="
echo

mkdir -p "$LAB_DIR/deliverables"

for f in ANTI_PATTERNS.md DORA_ASSESSMENT.md IMPROVEMENT_PLAN.md; do
  cp "$LAB_DIR/solutions/$f" "$LAB_DIR/deliverables/$f"
  echo "→ Copied solutions/$f → deliverables/$f"
done

echo
echo "Review and customize deliverables/ in your own words before submitting."
echo "Run ./scripts/check.sh to verify."