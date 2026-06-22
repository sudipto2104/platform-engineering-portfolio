#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Bash Fundamentals Lab — Check ==="

for script in backup_files.sh rotate_logs.sh system_info.sh disk_monitor.sh cleanup_temp.sh; do
  [[ -x "$DELIV/$script" ]] && pass "$script executable" || fail "$script"
done

grep -E '^#!/usr/bin/env bash' "$DELIV/backup_files.sh" | head -1 | grep -q . && pass "Shebang" || fail "Shebang"
grep -q 'date' "$DELIV/backup_files.sh" && pass "Command substitution/date" || fail "Timestamp backup"
grep -q 'gzip' "$DELIV/rotate_logs.sh" && pass "Log rotation" || fail "Log rotation"
grep -q 'hostname\|printf' "$DELIV/system_info.sh" && pass "System info output" || fail "System info"
grep -q 'THRESHOLD\|df' "$DELIV/disk_monitor.sh" && pass "Disk monitor" || fail "Disk monitor"
grep -q 'find\|TEMP_DIR' "$DELIV/cleanup_temp.sh" && pass "Cleanup script" || fail "Cleanup"

[[ -f "$DELIV/system_info_report.txt" ]] && pass "Info report" || fail "Info report"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }