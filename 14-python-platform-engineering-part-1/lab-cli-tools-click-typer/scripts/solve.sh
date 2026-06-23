#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== CLI Tools Click & Typer Lab — Solve ==="
mkdir -p "$DELIV/taskflow_cli_click" "$DELIV/taskflow_cli_typer" "$DELIV/config"
cp "$SRC/CLI_TOOLS_GUIDE.md" "$SRC/requirements.txt" "$DELIV/"
cp "$SRC/taskflow_cli_click/"*.py "$DELIV/taskflow_cli_click/"
cp "$SRC/taskflow_cli_typer/"*.py "$DELIV/taskflow_cli_typer/"
cp "$SRC/config/"* "$DELIV/config/"

if command -v python3 &>/dev/null; then
  python3 -m py_compile "$DELIV"/taskflow_cli_click/*.py "$DELIV"/taskflow_cli_typer/*.py 2>&1 | tail -1 || true
fi

echo "→ deliverables/taskflow_cli_click/, taskflow_cli_typer/"
echo "Run ./scripts/check.sh"