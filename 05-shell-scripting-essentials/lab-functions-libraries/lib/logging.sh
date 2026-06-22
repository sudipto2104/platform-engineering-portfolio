#!/usr/bin/env bash
# TaskFlow logging helpers — source into other scripts

log_info() {
  printf '[INFO] %s\n' "$*"
}

log_warn() {
  printf '[WARN] %s\n' "$*" >&2
}

log_error() {
  printf '[ERROR] %s\n' "$*" >&2
}

log_step() {
  local step="$1"
  shift
  log_info "Step ${step}: $*"
}