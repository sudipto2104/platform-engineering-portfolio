#!/usr/bin/env bash
# TaskFlow capstone setup automation
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../../03-version-control-git-github/taskflow-sandbox" 2>/dev/null && pwd || echo "")"

MODE="${1:-sandbox}"
OUTPUT_DIR="${2:-$LAB_DIR/deliverables/runtime}"

# shellcheck source=lib/taskflow.sh
source "$SCRIPT_DIR/lib/taskflow.sh"

mkdir -p "$OUTPUT_DIR/config"

tf_log "=== TaskFlow Setup ($MODE) ==="

validate_env.sh "$MODE"
tf_write_config "$LAB_DIR/templates/taskflow.env.example" "$OUTPUT_DIR/config/taskflow.env"

if [[ "$MODE" == "sandbox" && -n "$SANDBOX" && -d "$SANDBOX" ]]; then
  cd "$SANDBOX"
  init_services.sh "$MODE" "$OUTPUT_DIR/config"
  tf_log "Sandbox path: $SANDBOX"
  if curl -sf http://localhost:8080/health &>/dev/null; then
    tf_health_curl http://localhost:8080/health
  else
    tf_log "API not running — start with: python app.py"
  fi
else
  cd "$LAB_DIR"
  init_services.sh "$MODE" "$OUTPUT_DIR/config"
fi

{
  echo "# TaskFlow setup report"
  echo "- mode: $MODE"
  echo "- output: $OUTPUT_DIR"
  echo "- sandbox: ${SANDBOX:-n/a}"
  date -u
} > "$OUTPUT_DIR/SETUP_REPORT.md"

tf_log "Setup complete → $OUTPUT_DIR/SETUP_REPORT.md"