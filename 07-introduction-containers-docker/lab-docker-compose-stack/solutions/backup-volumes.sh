#!/usr/bin/env bash
# Backup TaskFlow Compose named volumes
set -euo pipefail

BACKUP_DIR="${1:-./backups}"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$BACKUP_DIR"

backup_volume() {
  local vol="$1" out="$BACKUP_DIR/${vol}-${TS}.tar"
  docker run --rm -v "${vol}:/data:ro" -v "${BACKUP_DIR}:/backup" alpine \
    tar -cf "/backup/$(basename "$out")" -C /data .
  echo "Backed up $vol → $out"
}

backup_volume taskflow_pg_data 2>/dev/null || echo "Skip pg (volume not found)"
backup_volume taskflow_redis_data 2>/dev/null || echo "Skip redis (volume not found)"