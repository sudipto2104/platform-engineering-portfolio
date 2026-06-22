#!/usr/bin/env bash
# Verify TaskFlow vision project deliverables.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0
FAIL=0
MIN_LINES=12

pass() { echo "✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL + 1)); }

check_doc() {
  local name="$1"
  local path="$2"
  local pattern="$3"
  if [[ ! -f "$path" ]]; then
    fail "$name exists"
    return
  fi
  local lines
  lines=$(grep -cve '^\s*$' "$path" 2>/dev/null || echo 0)
  if [[ "$lines" -lt "$MIN_LINES" ]]; then
    fail "$name has substantive content ($lines lines)"
    return
  fi
  if [[ -n "$pattern" ]] && ! grep -qiE "$pattern" "$path"; then
    fail "$name includes required sections"
    return
  fi
  pass "$name complete"
}

echo "=== TaskFlow Vision Project — Check ==="
echo

check_doc "VISION.md" "$PROJECT_DIR/VISION.md" "vision|problem|value"
check_doc "FEATURES.md" "$PROJECT_DIR/FEATURES.md" "feature|business|value"
check_doc "USER_STORIES.md" "$PROJECT_DIR/USER_STORIES.md" "as a|I want|so that"
check_doc "SUCCESS_METRICS.md" "$PROJECT_DIR/SUCCESS_METRICS.md" "metric|target|measure"

if [[ -f "$PROJECT_DIR/USER_STORIES.md" ]]; then
  count=$(grep -ciE "as an? \*\*|as a \*\*" "$PROJECT_DIR/USER_STORIES.md" 2>/dev/null || echo 0)
  if [[ "$count" -ge 6 ]]; then
    pass "USER_STORIES.md has $count user stories (6+ required)"
  else
    fail "USER_STORIES.md has $count user stories (need 6+)"
  fi
fi

if [[ -f "$PROJECT_DIR/FEATURES.md" ]]; then
  features=$(grep -ciE "^## Feature" "$PROJECT_DIR/FEATURES.md" 2>/dev/null || echo 0)
  if [[ "$features" -ge 4 ]]; then
    pass "FEATURES.md defines $features features (4+ required)"
  else
    fail "FEATURES.md defines $features features (need 4+)"
  fi
fi

echo
echo "Results: $PASS passed, $FAIL failed"
if [[ "$FAIL" -gt 0 ]]; then
  echo "Complete project docs using templates/, or run ./scripts/solve.sh."
  exit 1
fi
echo "TaskFlow vision project complete."