#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

echo "=== GitHub Collaboration Part 1 — Solve ==="
mkdir -p "$LAB_DIR/deliverables" "$SANDBOX/.github/ISSUE_TEMPLATE"

cp -r "$LAB_DIR/solutions/.github/"* "$SANDBOX/.github/" 2>/dev/null || true
cp "$LAB_DIR/solutions/ISSUE_AND_PR_WORKFLOW.md" "$LAB_DIR/deliverables/ISSUE_AND_PR_WORKFLOW.md"
cp "$LAB_DIR/solutions/SAMPLE_ISSUE.md" "$LAB_DIR/deliverables/SAMPLE_ISSUE.md"

cd "$SANDBOX"
git add .github/ 2>/dev/null || true
git diff --cached --quiet || git commit -q -m "chore: add GitHub issue and PR templates (#12)"

echo "→ GitHub templates copied to taskflow-sandbox/.github/"
echo "Run ./scripts/check.sh"