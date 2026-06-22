#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== HTTP / Nginx / TLS Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables" "$LAB_DIR/certs"

"$SCRIPT_DIR/generate-certs.sh"
cp "$LAB_DIR/solutions/HTTP_CURL_GUIDE.md" "$LAB_DIR/deliverables/HTTP_CURL_GUIDE.md"

if command -v docker &>/dev/null && docker info &>/dev/null 2>&1; then
  cd "$LAB_DIR"
  docker compose up -d --build 2>&1 | tail -3
  sleep 4
  if curl -sf http://localhost:8090/health &>/dev/null; then
    echo "  HTTP health: OK"
    curl -sk https://localhost:8443/health &>/dev/null && echo "  HTTPS health: OK" || echo "  HTTPS: check certs"
    {
      echo ""
      echo "## Live probe"
      echo "- HTTP :8090/health → OK"
    } >> "$LAB_DIR/deliverables/HTTP_CURL_GUIDE.md"
  fi
else
  echo "→ Docker not available — configs and certs generated"
fi

echo "Run ./scripts/check.sh"