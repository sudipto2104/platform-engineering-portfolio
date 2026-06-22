#!/usr/bin/env bash
# TaskFlow system health check — conditionals, validation, alerting
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="${1:-$SCRIPT_DIR/../workspace/thresholds.env}"

DISK_WARN=80
DISK_CRIT=90
MIN_MEM_MB=512
REQUIRED_BINARIES="curl bash"

if [[ -f "$CONFIG" ]]; then
  # shellcheck source=/dev/null
  source "$CONFIG"
fi

validate_number() {
  local val="$1" name="$2"
  if [[ ! "$val" =~ ^[0-9]+$ ]]; then
    echo "Invalid $name: $val" >&2
    return 1
  fi
}

check_disk() {
  local usage
  usage="$(df -h / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')"
  if [[ "$usage" -ge "$DISK_CRIT" ]]; then
    echo "CRITICAL disk ${usage}%"
    return 2
  elif [[ "$usage" -ge "$DISK_WARN" ]]; then
    echo "WARN disk ${usage}%"
    return 1
  fi
  echo "OK disk ${usage}%"
  return 0
}

check_binaries() {
  local missing=0 bin
  for bin in $REQUIRED_BINARIES; do
    if ! command -v "$bin" &>/dev/null; then
      echo "MISSING binary: $bin"
      missing=1
    fi
  done
  return "$missing"
}

check_file_readable() {
  local f="$1"
  if [[ ! -e "$f" ]]; then
    echo "File missing: $f"
    return 1
  elif [[ ! -r "$f" ]]; then
    echo "File not readable: $f"
    return 1
  fi
  echo "OK readable: $f"
  return 0
}

run_menu() {
  local choice
  echo "TaskFlow Health Check"
  echo "1) Disk  2) Binaries  3) Config  4) All  q) Quit"
  read -r -p "Choice: " choice
  case "$choice" in
    1) check_disk ;;
    2) check_binaries ;;
    3) check_file_readable "$CONFIG" ;;
    4)
      check_disk || true
      check_binaries || true
      check_file_readable "$CONFIG" || true
      ;;
    q|Q) exit 0 ;;
    *) echo "Invalid choice" >&2; return 1 ;;
  esac
}

validate_number "$DISK_WARN" "DISK_WARN"
validate_number "$DISK_CRIT" "DISK_CRIT"

if [[ "${BATCH_MODE:-}" == "1" ]]; then
  check_disk || true
  check_binaries || true
  check_file_readable "$CONFIG" || true
else
  run_menu
fi