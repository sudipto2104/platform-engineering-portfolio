#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

echo "=== CI/CD Code Quality Part 1 — Solve ==="
mkdir -p "$LAB_DIR/deliverables" "$SANDBOX/.github/workflows"

cp "$LAB_DIR/solutions/.github/workflows/quality.yml" "$SANDBOX/.github/workflows/quality.yml"
cp "$LAB_DIR/solutions/QUALITY_GATES.md" "$LAB_DIR/deliverables/QUALITY_GATES.md"

cd "$SANDBOX"
git add .github/workflows/quality.yml pyproject.toml frontend/ 2>/dev/null || true
git diff --cached --quiet || git commit -q -m "ci: add quality gate workflow (#20)" || true

# Local python checks if tools available
if command -v ruff &>/dev/null; then
  ruff check app.py && echo "  ruff: OK"
fi
if command -v black &>/dev/null; then
  black --check app.py && echo "  black: OK"
fi

echo "→ workflow installed at taskflow-sandbox/.github/workflows/quality.yml"
echo "Run ./scripts/check.sh"