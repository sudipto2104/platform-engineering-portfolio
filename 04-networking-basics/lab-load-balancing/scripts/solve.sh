#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== Load Balancing Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables"
cp "$LAB_DIR/solutions/LOAD_BALANCER_GUIDE.md" "$LAB_DIR/deliverables/LOAD_BALANCER_GUIDE.md"

if command -v docker &>/dev/null && docker info &>/dev/null 2>&1; then
  cd "$LAB_DIR"
  docker compose up -d --build 2>&1 | tail -3
  sleep 5
  versions=""
  for _ in 1 2 3 4 5 6; do
    v=$(curl -sf http://localhost:8095/health 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin).get('version','?'))" 2>/dev/null || echo "?")
    versions="$versions $v"
  done
  {
    echo ""
    echo "## Distribution sample"
    echo "Versions seen:$versions"
  } >> "$LAB_DIR/deliverables/LOAD_BALANCER_GUIDE.md"
  echo "  LB probes complete"
else
  echo "→ Docker not available — config docs generated"
fi

echo "Run ./scripts/check.sh"