#!/usr/bin/env bash
# Remove stale temp files older than MAX_AGE minutes
set -euo pipefail

TEMP_DIR="${1:-/tmp/taskflow}"
MAX_AGE="${2:-60}"  # minutes

mkdir -p "$TEMP_DIR"
COUNT=0
while IFS= read -r -d '' f; do
  rm -f "$f"
  COUNT=$((COUNT + 1))
done < <(find "$TEMP_DIR" -type f -mmin +"$MAX_AGE" -print0 2>/dev/null)

printf 'Cleaned %s file(s) older than %s min in %s\n' "$COUNT" "$MAX_AGE" "$TEMP_DIR"
exit 0