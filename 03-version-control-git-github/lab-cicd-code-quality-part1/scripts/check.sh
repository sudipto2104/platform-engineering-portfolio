#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== CI/CD Code Quality Part 1 — Check ==="

[[ -f "$SANDBOX/.github/workflows/quality.yml" ]] && pass "GitHub Actions workflow" || fail "Workflow"
grep -q ruff "$SANDBOX/.github/workflows/quality.yml" && pass "Ruff lint job" || fail "Ruff"
grep -q black "$SANDBOX/.github/workflows/quality.yml" && pass "Black format job" || fail "Black"
grep -qE 'eslint|npm run lint' "$SANDBOX/.github/workflows/quality.yml" && pass "ESLint job" || fail "ESLint"
grep -qE 'prettier|npm run format' "$SANDBOX/.github/workflows/quality.yml" && pass "Prettier job" || fail "Prettier"
grep -qE 'audit|pip-audit' "$SANDBOX/.github/workflows/quality.yml" && pass "Security audit job" || fail "Audit"

[[ -f "$SANDBOX/frontend/package.json" ]] && pass "frontend package.json" || fail "package.json"
[[ -f "$SANDBOX/pyproject.toml" ]] && pass "pyproject.toml" || fail "pyproject.toml"
[[ -f "$LAB_DIR/deliverables/QUALITY_GATES.md" ]] && pass "Quality gates doc" || fail "Quality doc"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }