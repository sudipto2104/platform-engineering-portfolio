#!/usr/bin/env bash
# TaskFlow log analysis — grep + awk + sed pipeline.
set -euo pipefail

readonly SCRIPT_NAME="analyze-taskflow-logs"
readonly LOG_DIR="${LOG_DIR:-/tmp/taskflow-text}"
readonly LOG_FILE="$LOG_DIR/${SCRIPT_NAME}.log"
_resolve_log() {
  local base
  base="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  for candidate in "$base/../../taskflow-workspace/logs/taskflow.log" "$base/../../../taskflow-workspace/logs/taskflow.log"; do
    [[ -f "$candidate" ]] && echo "$candidate" && return 0
  done
  echo "$base/../../taskflow-workspace/logs/taskflow.log"
}
readonly INPUT="${1:-$(_resolve_log)}"
readonly OUTPUT="${2:-$(dirname "${BASH_SOURCE[0]}")/../../deliverables/LOG_SUMMARY.md}"

mkdir -p "$LOG_DIR" "$(dirname "$OUTPUT")"

log() {
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [$SCRIPT_NAME] $*" | tee -a "$LOG_FILE"
}

[[ -f "$INPUT" ]] || { log "ERROR missing $INPUT"; exit 2; }
log "INFO analyzing $INPUT"

total=$(wc -l < "$INPUT" | tr -d ' ')
errors=$(grep -c ERROR "$INPUT" || true)
warns=$(grep -c WARN "$INPUT" || true)
infos=$(grep -c INFO "$INPUT" || true)

# awk — average duration_ms for GET /api/tasks
avg_ms=$(grep 'GET /api/tasks' "$INPUT" | awk -F'duration_ms=' '{sum+=$2; n++} END {if(n) printf "%.0f", sum/n; else print "n/a"}')

# sed — normalize ERROR lines to short form
error_samples=$(grep ERROR "$INPUT" | sed -E 's/^([0-9T:Z]+) ERROR /\1 | /' | head -5)

# grep + pipe — slow queries over 500ms
slow=$(grep 'slow_query' "$INPUT" | awk -F'duration_ms=' '$2 >= 500 {print}' | wc -l | tr -d ' ')

cat > "$OUTPUT" <<EOF
# TaskFlow Log Summary

**Source:** \`$INPUT\`  
**Generated:** $(date -u +%Y-%m-%dT%H:%M:%SZ)

## Counts

| Level | Count |
|-------|-------|
| INFO | $infos |
| WARN | $warns |
| ERROR | $errors |
| **Total lines** | $total |

## API performance

- Average \`GET /api/tasks\` duration: **${avg_ms}ms**
- Slow queries (≥500ms): **$slow**

## Sample errors (sed-trimmed)

\`\`\`
$(echo "$error_samples")
\`\`\`

## Top endpoints (awk)

\`\`\`
$(grep -oE 'GET|POST [^ ]+' "$INPUT" | sort | uniq -c | sort -rn | head -5)
\`\`\`
EOF

log "INFO wrote $OUTPUT"
cat "$OUTPUT"