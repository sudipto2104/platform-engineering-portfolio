#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== Packages & Services Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables"
cp "$LAB_DIR/solutions/STACK_STATUS.md" "$LAB_DIR/deliverables/STACK_STATUS.md"

if command -v docker &>/dev/null && docker info &>/dev/null 2>&1; then
  echo "→ Starting Docker Compose stack"
  cd "$LAB_DIR"
  docker compose up -d --build 2>&1 | tail -5
  sleep 5
  if curl -sf http://localhost:8088/health &>/dev/null; then
    echo "  nginx proxy health: OK"
    {
      echo ""
      echo "## Compose verification ($(date -u +%Y-%m-%dT%H:%M:%SZ))"
      echo "- nginx /health: OK"
      docker compose ps --format "table {{.Name}}\t{{.Status}}" 2>/dev/null || docker compose ps
    } >> "$LAB_DIR/deliverables/STACK_STATUS.md"
  else
    echo "  stack started — run: curl http://localhost:8088/health"
  fi
else
  echo "→ Docker not available — deliverables written; use Ubuntu APT_SETUP.md on VM"
fi

echo "Run ./scripts/check.sh"