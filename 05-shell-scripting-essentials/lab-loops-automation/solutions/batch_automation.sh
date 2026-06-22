#!/usr/bin/env bash
# TaskFlow batch automation — loops, arrays, file iteration
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE="${WORKSPACE:-$SCRIPT_DIR/../workspace}"

deploy_servers() {
  local servers=()
  while IFS= read -r line; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    servers+=("$line")
  done < "$WORKSPACE/servers.txt"

  for host in "${servers[@]}"; do
    echo "DEPLOY simulate → $host"
  done
}

process_logs() {
  local log="$WORKSPACE/logs/api.log" count=0
  while IFS= read -r line; do
    if [[ "$line" == ERROR* ]]; then
      echo "ALERT: $line"
      count=$((count + 1))
    fi
  done < "$log"
  echo "Error lines: $count"
}

validate_configs() {
  local required_keys=("APP_NAME" "LOG_LEVEL")
  local file="$WORKSPACE/configs/app.env" key missing=0
  for key in "${required_keys[@]}"; do
    if ! grep -q "^${key}=" "$file"; then
      echo "Missing key: $key"
      missing=1
    fi
  done
  return "$missing"
}

rotate_backups() {
  local dir="$WORKSPACE/backups" keep=3 n=0
  mkdir -p "$dir"
  for i in $(seq 1 5); do
    echo "backup-$i" > "$dir/backup-$i.tar.gz"
  done
  for f in $(ls -1t "$dir"/*.tar.gz 2>/dev/null); do
    n=$((n + 1))
    if [[ "$n" -gt "$keep" ]]; then
      rm -f "$f"
      echo "Removed old: $f"
    fi
  done
}

multi_env_deploy() {
  until [[ ! -f "$WORKSPACE/environments.txt" ]]; do
    while IFS= read -r env; do
      [[ -z "$env" ]] && continue
      echo "Pipeline → $env"
    done < "$WORKSPACE/environments.txt"
    break
  done
}

ACTION="${1:-all}"
case "$ACTION" in
  deploy) deploy_servers ;;
  logs) process_logs ;;
  validate) validate_configs ;;
  rotate) rotate_backups ;;
  envs) multi_env_deploy ;;
  all)
    deploy_servers
    process_logs
    validate_configs
    rotate_backups
    multi_env_deploy
    ;;
  *) echo "Usage: $0 {deploy|logs|validate|rotate|envs|all}" >&2; exit 1 ;;
esac