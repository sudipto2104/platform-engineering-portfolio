#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== DevOps Transformation Capstone — Solve ==="

mkdir -p "$PROJECT_DIR/deliverables/prototypes" "$PROJECT_DIR/deliverables/data"

for f in MATURITY_ASSESSMENT.md TRANSFORMATION_STRATEGY.md BUSINESS_CASE.md; do
  cp "$PROJECT_DIR/examples/$f" "$PROJECT_DIR/deliverables/$f"
  echo "→ deliverables/$f"
done

cp "$PROJECT_DIR/examples/prototypes/"*.sh "$PROJECT_DIR/deliverables/prototypes/"
cp "$PROJECT_DIR/examples/data/sample_tickets.csv" "$PROJECT_DIR/deliverables/data/"
chmod +x "$PROJECT_DIR/deliverables/prototypes/"*.sh
echo "→ deliverables/prototypes/"

echo
echo "→ Running prototype demos"
"$PROJECT_DIR/deliverables/prototypes/onboarding-audit.sh" || true
"$PROJECT_DIR/deliverables/prototypes/toil-ticket-report.sh" \
  "$PROJECT_DIR/deliverables/data/sample_tickets.csv"

echo
echo "Run ./scripts/check.sh"