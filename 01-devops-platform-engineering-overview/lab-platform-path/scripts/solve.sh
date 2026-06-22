#!/usr/bin/env bash
# Run the full platform-path solution: git → build → terraform → scale → verify.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TASKFLOW_DIR="$(cd "$LAB_DIR/../taskflow" && pwd)"
TF_DIR="$LAB_DIR/terraform"

echo "=== Platform Path Lab — Solve ==="
echo

# Layer 1: Version control
echo "→ Git: initializing and committing TaskFlow source"
cd "$TASKFLOW_DIR"
if [[ ! -d .git ]]; then
  git init -q
  git config user.email "${GIT_AUTHOR_EMAIL:-student@taskflow.local}"
  git config user.name "${GIT_AUTHOR_NAME:-TaskFlow Student}"
fi
git add -A
if git diff --cached --quiet 2>/dev/null; then
  echo "  (working tree already committed)"
else
  git commit -m "feat: initial TaskFlow week1 stub" -q
fi
echo "  commit: $(git rev-parse --short HEAD)"

# Layer 2: Containers
echo "→ Docker: building taskflow:week1"
docker build -t taskflow:week1 "$TASKFLOW_DIR" -q
echo "  image: taskflow:week1 ($(docker image inspect taskflow:week1 --format '{{.Id}}' | cut -c8-19))"

# Stop dev containers that might conflict on ports
docker rm -f taskflow-dev 2>/dev/null || true
for i in 1 2 3; do
  docker rm -f "taskflow-replica-${i}" 2>/dev/null || true
done

# Layer 3 & 4: Terraform IaC + scale
echo "→ Terraform: init and apply with 3 replicas"
cd "$TF_DIR"
terraform init -input=false
terraform apply -auto-approve -input=false -var="replica_count=3"

echo
echo "→ Replica URLs:"
terraform output -json replica_urls | python3 -c "import sys,json; [print(' ',u) for u in json.load(sys.stdin)]"

# Layer 5: Quick health probe
echo
echo "→ Health checks:"
for port in 9080 9081 9082; do
  curl -sf "http://localhost:${port}/health" | python3 -c "import sys,json; d=json.load(sys.stdin); print(f'  :{port} → {d[\"status\"]} ({d[\"service\"]})')" 2>/dev/null \
    || echo "  :${port} → unreachable"
done

echo
echo "Run ./scripts/observe.sh to inspect logs, stats, and Terraform state."
echo "Run ./scripts/check.sh to verify the lab."