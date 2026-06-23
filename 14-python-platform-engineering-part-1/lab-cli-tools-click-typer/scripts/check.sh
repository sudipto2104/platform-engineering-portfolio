#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
CLICK="$DELIV/taskflow_cli_click/main.py"
TYPER="$DELIV/taskflow_cli_typer/main.py"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== CLI Tools Click & Typer Lab — Check ==="

[[ -f "$DELIV/requirements.txt" ]] && pass "requirements.txt" || fail "requirements.txt"
grep -q 'click' "$DELIV/requirements.txt" && pass "click dependency" || fail "click dependency"
grep -q 'typer' "$DELIV/requirements.txt" && pass "typer dependency" || fail "typer dependency"

[[ -f "$CLICK" ]] && pass "Click main.py" || fail "Click main.py"
[[ -f "$TYPER" ]] && pass "Typer main.py" || fail "Typer main.py"
[[ -f "$DELIV/config/taskflow.yaml.example" ]] && pass "Config template" || fail "Config template"

grep -q 'import click\|@click' "$CLICK" && pass "Click framework" || fail "Click framework"
grep -q 'import typer\|typer.Typer' "$TYPER" && pass "Typer framework" || fail "Typer framework"
grep -q '@click.group\|@click.command' "$CLICK" && pass "Click multi-command" || fail "Click multi-command"
grep -q '@app.command' "$TYPER" && pass "Typer commands" || fail "Typer commands"

for cmd in deploy status logs config; do
  grep -q "$cmd" "$CLICK" && pass "Click: $cmd" || fail "Click: $cmd"
  grep -q "$cmd" "$TYPER" && pass "Typer: $cmd" || fail "Typer: $cmd"
done

grep -q 'yaml\|YAML\|config' "$CLICK" && pass "Click config handling" || fail "Click config handling"
grep -qiE 'self-service|multi-command|platform' "$DELIV/CLI_TOOLS_GUIDE.md" && pass "CLI guide" || fail "CLI guide"
grep -qiE 'click|typer' "$DELIV/CLI_TOOLS_GUIDE.md" && pass "Framework comparison" || fail "Framework comparison"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }