#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== Docker Compose Stack Lab — Solve ==="
mkdir -p "$DELIV"

cp "$LAB_DIR/solutions/docker-compose.yml" "$LAB_DIR/solutions/COMPOSE_GUIDE.md" "$DELIV/"
cp "$LAB_DIR/solutions/backup-volumes.sh" "$LAB_DIR/solutions/restore-volumes.sh" "$DELIV/"
chmod +x "$DELIV/backup-volumes.sh" "$DELIV/restore-volumes.sh"
cp "$LAB_DIR/config/taskflow.env" "$DELIV/taskflow.env"

echo "→ deliverables/docker-compose.yml + backup scripts"
echo "Run ./scripts/check.sh"