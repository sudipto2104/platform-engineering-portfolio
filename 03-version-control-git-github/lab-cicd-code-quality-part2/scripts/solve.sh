#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

echo "=== CI/CD Code Quality Part 2 — Solve ==="
mkdir -p "$LAB_DIR/deliverables"

"$LAB_DIR/../lab-cicd-code-quality-part1/scripts/solve.sh" 2>/dev/null || true

cp "$LAB_DIR/solutions/.github/workflows/quality-strict.yml" "$SANDBOX/.github/workflows/quality.yml"
cp "$LAB_DIR/solutions/BRANCH_PROTECTION.md" "$LAB_DIR/deliverables/BRANCH_PROTECTION.md"

# Break/fix demo (local only)
cd "$SANDBOX/frontend"
if command -v npm &>/dev/null && [[ -f package.json ]]; then
  npm ci --silent 2>/dev/null || npm install --silent 2>/dev/null || true
  if npm run lint 2>/dev/null; then
    echo "  lint baseline: OK"
  fi
fi

cd "$SANDBOX"
git add .github/workflows/quality.yml
git diff --cached --quiet || git commit -q -m "ci: enforce strict quality gates (#21)"

{
  echo ""
  echo "## Gate test ($(date -u +%Y-%m-%dT%H:%M:%SZ))"
  echo "- Strict workflow replaces permissive audit (\`|| true\` removed)"
  echo "- Branch protection doc completed"
} >> "$LAB_DIR/deliverables/BRANCH_PROTECTION.md"

echo "Run ./scripts/check.sh"