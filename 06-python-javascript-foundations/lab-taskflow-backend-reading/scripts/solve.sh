#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
API="$LAB_DIR/workspace/taskflow-api"
DELIV="$LAB_DIR/deliverables"

echo "=== TaskFlow Backend Reading Lab — Solve ==="
mkdir -p "$DELIV"

cp "$LAB_DIR/solutions/BACKEND_READING_NOTES.md" "$DELIV/BACKEND_READING_NOTES.md"

{
  echo ""
  echo "## Codebase map ($(date -u +%Y-%m-%dT%H:%M:%SZ))"
  echo '```'
  find "$API" -type f \( -name '*.py' -o -name 'requirements.txt' \) | sort
  echo '```'
  echo ""
  echo "## Key symbols"
  grep -Rn "def create_app\|class TaskService\|class TaskCreate\|register_blueprint" "$API/app" 2>/dev/null || true
} >> "$DELIV/BACKEND_READING_NOTES.md"

echo "→ deliverables/BACKEND_READING_NOTES.md"
echo "Run ./scripts/check.sh"