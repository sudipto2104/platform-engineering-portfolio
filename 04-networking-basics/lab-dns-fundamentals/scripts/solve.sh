#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=== DNS Fundamentals Lab — Solve ==="
mkdir -p "$LAB_DIR/deliverables"

cp "$LAB_DIR/solutions/DNS_RUNBOOK.md" "$LAB_DIR/deliverables/DNS_RUNBOOK.md"

{
  echo ""
  echo "## Zone file parse ($(date -u +%Y-%m-%dT%H:%M:%SZ))"
  echo '```'
  grep -E '^(api|www|health|taskflow)' "$LAB_DIR/workspace/taskflow.zone" | head -10
  echo '```'
  echo ""
  echo "## Local dig simulation (grep zone)"
  echo "- api.taskflow.local A → $(grep 'api.taskflow.local' "$LAB_DIR/workspace/taskflow.zone" | awk '{print $NF}')"
  echo "- health CNAME → api (see zone)"
} >> "$LAB_DIR/deliverables/DNS_RUNBOOK.md"

echo "Run ./scripts/check.sh"