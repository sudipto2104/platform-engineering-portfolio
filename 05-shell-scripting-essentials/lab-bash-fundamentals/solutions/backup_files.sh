#!/usr/bin/env bash
# TaskFlow file backup — timestamped tar archive
set -euo pipefail

SOURCE_DIR="${1:-.}"
DEST_DIR="${2:-./backups}"
TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"
ARCHIVE_NAME="taskflow-backup-${TIMESTAMP}.tar.gz"

mkdir -p "$DEST_DIR"
tar -czf "${DEST_DIR}/${ARCHIVE_NAME}" -C "$SOURCE_DIR" .
printf 'Backup created: %s/%s\n' "$DEST_DIR" "$ARCHIVE_NAME"
exit 0