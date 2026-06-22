#!/usr/bin/env bash
# Apply secure permissions to simulated TaskFlow server tree.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../workspace/taskflow-server" && pwd)"

log() { echo "[apply-permissions] $*"; }

mkdir -p "$ROOT"/{app,config,logs,data,public}
echo 'TASKFLOW_VERSION=week2' > "$ROOT/config/app.env"
echo 'week2 bootcamp' > "$ROOT/app/VERSION"
echo 'sample log line' > "$ROOT/logs/taskflow.log"
echo '{}' > "$ROOT/data/tasks.json"
echo 'TaskFlow' > "$ROOT/public/index.html"

# Directories: 750/770 as appropriate; files: minimal access
chmod 755 "$ROOT"
chmod 750 "$ROOT/app" "$ROOT/config" "$ROOT/data" "$ROOT/logs"
chmod 755 "$ROOT/public"

chmod 640 "$ROOT/config/app.env"
chmod 644 "$ROOT/app/VERSION" "$ROOT/public/index.html"
chmod 660 "$ROOT/logs/taskflow.log"
chmod 600 "$ROOT/data/tasks.json"

log "Permissions applied under $ROOT"
find "$ROOT" -ls 2>/dev/null || find "$ROOT"