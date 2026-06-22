#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== EC2 TaskFlow Deploy Lab — Solve ==="
mkdir -p "$DELIV"
cp "$LAB_DIR/solutions/"*.{sh,yml,conf,json,md} "$DELIV/" 2>/dev/null || \
  cp "$LAB_DIR/solutions/user-data.sh" "$LAB_DIR/solutions/docker-compose.ec2.yml" \
     "$LAB_DIR/solutions/nginx-ec2.conf" "$LAB_DIR/solutions/security-groups.json" \
     "$LAB_DIR/solutions/EC2_DEPLOY_GUIDE.md" "$DELIV/"
chmod +x "$DELIV/user-data.sh" 2>/dev/null || true

echo "→ deliverables/ EC2 deployment bundle"
echo "Run ./scripts/check.sh"