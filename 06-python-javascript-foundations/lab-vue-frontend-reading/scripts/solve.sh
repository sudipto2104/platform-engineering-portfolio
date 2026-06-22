#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
UI="$LAB_DIR/workspace/taskflow-ui"
DELIV="$LAB_DIR/deliverables"

echo "=== Vue Frontend Reading Lab — Solve ==="
mkdir -p "$DELIV"

cp "$LAB_DIR/solutions/FRONTEND_READING_NOTES.md" "$DELIV/FRONTEND_READING_NOTES.md"

{
  echo ""
  echo "## Component tree ($(date -u +%Y-%m-%dT%H:%M:%SZ))"
  echo '```'
  find "$UI/src" -type f | sort
  echo '```'
  echo ""
  echo "## Vue patterns found"
  grep -Rn "defineStore\|createRouter\|defineProps\|onMounted" "$UI/src" 2>/dev/null || true
} >> "$DELIV/FRONTEND_READING_NOTES.md"

echo "→ deliverables/FRONTEND_READING_NOTES.md"
echo "Run ./scripts/check.sh"