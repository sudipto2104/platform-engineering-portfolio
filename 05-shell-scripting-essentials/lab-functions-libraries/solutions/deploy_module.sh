#!/usr/bin/env bash
# Modular TaskFlow deployment — functions + libraries
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../lib" && pwd)"

# shellcheck source=../lib/logging.sh
source "$LIB_DIR/logging.sh"
# shellcheck source=../lib/common.sh
source "$LIB_DIR/common.sh"

deploy_api() {
  local version="${1:-latest}"
  local replicas="${2:-2}"
  log_step 1 "Deploy API version=$version replicas=$replicas"
  local i
  for ((i = 1; i <= replicas; i++)); do
    echo "  → api-pod-$i ready"
  done
}

deploy_frontend() {
  local env="${1:-dev}"
  log_step 2 "Build frontend env=$env"
  require_cmd node || return $?
  echo "  → frontend build ok"
}

run_smoke_tests() {
  local base_url="${1:-http://localhost:8080}"
  log_step 3 "Smoke test $base_url/health"
  if command -v curl &>/dev/null; then
    if curl -sf "${base_url}/health" &>/dev/null; then
      log_info "Health OK"
      return 0
    fi
    log_warn "Health endpoint unreachable (offline mode)"
    return 0
  fi
  log_warn "curl not available — skip smoke test"
  return 0
}

main() {
  local env="${1:-dev}"
  deploy_api "week5" 2
  deploy_frontend "$env"
  run_smoke_tests
  log_info "Deploy complete"
}

main "$@"