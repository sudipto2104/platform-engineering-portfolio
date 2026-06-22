#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/taskflow.sh
source "$SCRIPT_DIR/lib/taskflow.sh"

MODE="${1:-sandbox}"
CONFIG_DIR="${2:-./config}"

mkdir -p "$CONFIG_DIR"

case "$MODE" in
  sandbox)
    tf_log "Init sandbox — pip dependencies"
    if [[ -f requirements.txt ]]; then
      python3 -m pip install -q -r requirements.txt 2>/dev/null || tf_log "pip install skipped (offline)"
    fi
    ;;
  full)
    tf_log "Init full stack — postgres, redis, api, frontend"
    echo "CREATE DATABASE taskflow;" > "$CONFIG_DIR/init.sql"
    echo "redis ping OK (simulated)" > "$CONFIG_DIR/redis.status"
    echo "npm ci (simulated)" > "$CONFIG_DIR/frontend.status"
    ;;
esac

tf_log "Service init complete"