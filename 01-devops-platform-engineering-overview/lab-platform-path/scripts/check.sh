#!/usr/bin/env bash
# Verify the platform-path lab end state: git → docker → terraform → scale → health.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TASKFLOW_DIR="$(cd "$LAB_DIR/../taskflow" && pwd)"
TF_DIR="$LAB_DIR/terraform"

PASS=0
FAIL=0

pass() { echo "✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL + 1)); }

echo "=== Platform Path Lab — Check ==="
echo

# Layer 1: Version control
if [[ -d "$TASKFLOW_DIR/.git" ]] && git -C "$TASKFLOW_DIR" rev-parse HEAD &>/dev/null; then
  pass "Git repository initialized with at least one commit"
else
  fail "Git repository initialized with at least one commit"
fi

# Layer 2: Containers
if docker image inspect taskflow:week1 &>/dev/null; then
  pass "Docker image taskflow:week1 exists"
else
  fail "Docker image taskflow:week1 exists"
fi

if [[ -f "$TASKFLOW_DIR/Dockerfile" ]]; then
  pass "Dockerfile present in taskflow/"
else
  fail "Dockerfile present in taskflow/"
fi

# Layer 3: Infrastructure as Code
if [[ -d "$TF_DIR/.terraform" ]]; then
  pass "Terraform initialized"
else
  fail "Terraform initialized"
fi

if [[ -f "$TF_DIR/terraform.tfstate" ]] && grep -q 'docker_container.taskflow' "$TF_DIR/terraform.tfstate" 2>/dev/null; then
  pass "Terraform state contains TaskFlow containers"
else
  fail "Terraform state contains TaskFlow containers"
fi

# Layer 4: Scale
REPLICA_COUNT=0
if [[ -f "$TF_DIR/terraform.tfstate" ]]; then
  REPLICA_COUNT=$(cd "$TF_DIR" && terraform output -raw replica_count 2>/dev/null || echo "0")
fi
if [[ "$REPLICA_COUNT" -ge 3 ]]; then
  pass "Terraform scaled to 3+ replicas (replica_count=$REPLICA_COUNT)"
else
  fail "Terraform scaled to 3+ replicas (replica_count=$REPLICA_COUNT)"
fi

# Layer 5: Observability / health
HEALTHY=0
for port in 9080 9081 9082; do
  if curl -sf "http://localhost:${port}/health" &>/dev/null; then
    HEALTHY=$((HEALTHY + 1))
  fi
done
if [[ "$HEALTHY" -ge 3 ]]; then
  pass "All 3 replica health endpoints respond (9080–9082)"
else
  fail "All 3 replica health endpoints respond (9080–9082) — got $HEALTHY/3"
fi

echo
echo "Results: $PASS passed, $FAIL failed"
if [[ "$FAIL" -gt 0 ]]; then
  echo "Run ./scripts/solve.sh to complete the lab, then re-run check."
  exit 1
fi
echo "Platform path lab complete."