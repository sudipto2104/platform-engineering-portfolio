#!/usr/bin/env bash
# Observability slice: container logs, resource stats, and Terraform state.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TF_DIR="$LAB_DIR/terraform"

section() {
  echo
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo " $1"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

section "1. Running TaskFlow containers"
docker ps --filter "label=app=taskflow" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null \
  || docker ps --filter "name=taskflow" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

section "2. Container logs (last 5 lines per replica)"
for name in taskflow-replica-1 taskflow-replica-2 taskflow-replica-3; do
  if docker inspect "$name" &>/dev/null; then
    echo "--- $name ---"
    docker logs --tail 5 "$name" 2>&1 || true
  fi
done

section "3. Container resource stats (one snapshot)"
IDS=$(docker ps -q --filter "label=app=taskflow" 2>/dev/null | tr '\n' ' ')
if [[ -n "${IDS// }" ]]; then
  docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}" $IDS
else
  echo "(no taskflow containers running)"
fi

section "4. Terraform outputs"
if [[ -d "$TF_DIR/.terraform" ]]; then
  (cd "$TF_DIR" && terraform output) 2>/dev/null || echo "(terraform not applied yet)"
else
  echo "(terraform not initialized — run solve.sh first)"
fi

section "5. Terraform state summary"
if [[ -f "$TF_DIR/terraform.tfstate" ]]; then
  (cd "$TF_DIR" && terraform state list) 2>/dev/null || true
  echo
  echo "Full state record (terraform show):"
  (cd "$TF_DIR" && terraform show -no-color) 2>/dev/null | head -80
  echo "... (truncated — run 'terraform show' in terraform/ for full output)"
else
  echo "(no terraform.tfstate — run solve.sh first)"
fi

section "6. API spot-check"
for port in 9080 9081 9082; do
  echo -n "GET http://localhost:${port}/api/tasks → "
  curl -sf "http://localhost:${port}/api/tasks" 2>/dev/null \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(f'{d[\"count\"]} tasks')" \
    || echo "unreachable"
done

echo