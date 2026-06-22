#!/usr/bin/env bash
# TaskFlow common helpers

require_cmd() {
  local cmd="$1"
  if ! command -v "$cmd" &>/dev/null; then
    log_error "Required command not found: $cmd"
    return 127
  fi
}

assert_file() {
  local path="$1"
  if [[ ! -f "$path" ]]; then
    log_error "Missing file: $path"
    return 1
  fi
}

retry() {
  local attempts="${1:-3}"
  shift
  local n=1
  until "$@"; do
    if [[ "$n" -ge "$attempts" ]]; then
      log_error "Command failed after ${attempts} attempts: $*"
      return 1
    fi
    log_warn "Retry $n/$attempts: $*"
    n=$((n + 1))
    sleep 1
  done
}