#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Linux Commands Lab — Check ==="

[[ -f "$LAB_DIR/reference/COMMAND_CHEATSHEET.md" ]] && pass "Cheatsheet present" || fail "Cheatsheet"
cmds=$(grep -cE '^\| `[a-z]' "$LAB_DIR/reference/COMMAND_CHEATSHEET.md" 2>/dev/null || echo 0)
[[ "$cmds" -ge 50 ]] && pass "$cmds commands in cheatsheet (50+)" || fail "$cmds commands (need 50+)"

[[ -f "$LAB_DIR/deliverables/COMMAND_PRACTICE_LOG.md" ]] && pass "Practice log" || fail "Practice log"
if [[ -f "$LAB_DIR/deliverables/COMMAND_PRACTICE_LOG.md" ]]; then
  grep -qiE "navigation|file|search|52|50" "$LAB_DIR/deliverables/COMMAND_PRACTICE_LOG.md" \
    && pass "Practice log structured" || fail "Practice log structure"
fi

[[ -f "$LAB_DIR/exercises/DRILLS.md" ]] && pass "Drills present" || fail "Drills"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }
echo "Linux commands lab complete."