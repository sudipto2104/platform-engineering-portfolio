#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/taskflow.sh
source "$SCRIPT_DIR/lib/taskflow.sh"

MODE="${1:-sandbox}"

case "$MODE" in
  sandbox)
    tf_require_cmds bash python3 curl || exit 1
    ;;
  full)
    tf_require_cmds bash node npm python3 curl docker || exit 1
    ;;
  *)
    echo "Unknown mode: $MODE" >&2
    exit 1
    ;;
esac

tf_log "Environment validation passed ($MODE)"