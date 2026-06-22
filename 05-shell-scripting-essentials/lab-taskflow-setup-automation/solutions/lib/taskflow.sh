#!/usr/bin/env bash

tf_log() { printf '[taskflow] %s\n' "$*"; }

tf_require_cmds() {
  local missing=0 cmd
  for cmd in "$@"; do
    if ! command -v "$cmd" &>/dev/null; then
      tf_log "missing: $cmd"
      missing=1
    fi
  done
  return "$missing"
}

tf_write_config() {
  local template="$1" dest="$2"
  cp "$template" "$dest"
  tf_log "config → $dest"
}

tf_health_curl() {
  local url="$1"
  if curl -sf "$url" &>/dev/null; then
    tf_log "health OK $url"
    return 0
  fi
  tf_log "health FAIL $url"
  return 1
}