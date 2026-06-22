#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SOL="$LAB_DIR/solutions"

echo "=== TaskFlow Setup Automation Lab — Solve ==="
mkdir -p "$DELIV/lib" "$DELIV/runtime/config"

cp "$SOL/setup_taskflow.sh" "$SOL/validate_env.sh" "$SOL/init_services.sh" "$DELIV/"
cp "$SOL/lib/taskflow.sh" "$DELIV/lib/"
cp "$SOL/AUTOMATION_RUNBOOK.md" "$DELIV/"
chmod +x "$DELIV/"*.sh "$DELIV/lib/"*.sh

PATH="$DELIV:$PATH" "$DELIV/setup_taskflow.sh" sandbox "$DELIV/runtime"
PATH="$DELIV:$PATH" "$DELIV/setup_taskflow.sh" full "$DELIV/runtime-full"

echo "→ deliverables/setup_taskflow.sh + runtime/"
echo "Run ./scripts/check.sh"