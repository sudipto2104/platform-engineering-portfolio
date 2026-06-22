#!/usr/bin/env bash
# Restore TaskFlow volume from tar backup
set -euo pipefail

ARCHIVE="${1:?Usage: restore-volumes.sh <archive.tar> <volume_name>}"
VOLUME="${2:?volume name e.g. taskflow_pg_data}"

docker volume create "$VOLUME" >/dev/null 2>&1 || true
docker run --rm -v "${VOLUME}:/data" -v "$(dirname "$ARCHIVE"):/backup:ro" alpine \
  sh -c "cd /data && tar -xf /backup/$(basename "$ARCHIVE")"
echo "Restored $ARCHIVE → $VOLUME"