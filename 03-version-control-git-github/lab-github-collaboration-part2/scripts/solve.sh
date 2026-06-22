#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

echo "=== GitHub Collaboration Part 2 — Solve ==="
mkdir -p "$LAB_DIR/deliverables"

"$LAB_DIR/../lab-github-collaboration-part1/scripts/solve.sh" 2>/dev/null || true

cp "$LAB_DIR/solutions/PR_REVIEW_GUIDE.md" "$LAB_DIR/deliverables/PR_REVIEW_GUIDE.md"
cp "$LAB_DIR/solutions/SAMPLE_PR_REVIEW.md" "$LAB_DIR/deliverables/SAMPLE_PR_REVIEW.md"

# Simulate merged feature branch cleanup
cd "$SANDBOX"
git checkout main 2>/dev/null || true
git branch -d feature/12-add-task-count 2>/dev/null || true

echo "→ branch cleanup simulated"
echo "Run ./scripts/check.sh"