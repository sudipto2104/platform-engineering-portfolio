#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$PROJECT_DIR/deliverables"

PASS=0
FAIL=0

pass() { echo "✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL + 1)); }

check_doc() {
  local name="$1" path="$2" min="$3" pattern="$4"
  if [[ ! -f "$path" ]]; then fail "$name exists"; return; fi
  local lines
  lines=$(grep -cve '^\s*$' "$path" 2>/dev/null || echo 0)
  if [[ "$lines" -lt "$min" ]]; then fail "$name ($lines lines, need $min+)"; return; fi
  if [[ -n "$pattern" ]] && ! grep -qiE "$pattern" "$path"; then fail "$name missing required sections"; return; fi
  pass "$name"
}

echo "=== TaskFlow Documentation Project — Check ==="
echo

check_doc "README.md" "$DELIV/README.md" 20 "quick start|docker|prerequisite"
check_doc "CONTRIBUTING.md" "$DELIV/CONTRIBUTING.md" 15 "pull request|commit|contribut"
check_doc "docs/ARCHITECTURE.md" "$DELIV/docs/ARCHITECTURE.md" 20 "component|architecture|design"
check_doc "docs/API.md" "$DELIV/docs/API.md" 25 "/health|/api/tasks|endpoint"

echo
echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Complete deliverables/ or run ./scripts/solve.sh"; exit 1; }
echo "Documentation project complete."