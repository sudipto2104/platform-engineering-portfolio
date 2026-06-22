#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== K8s Backend Deployment Lab — Check ==="

[[ -f "$DELIV/deployment.yaml" ]] && pass "Deployment" || fail "Deployment"
[[ -f "$DELIV/service.yaml" ]] && pass "Service" || fail "Service"
grep -q 'replicas: 3' "$DELIV/deployment.yaml" && pass "3 replicas" || fail "Replicas"
grep -q 'ClusterIP\|type: ClusterIP' "$DELIV/service.yaml" && pass "ClusterIP" || fail "ClusterIP"
grep -q 'livenessProbe' "$DELIV/deployment.yaml" && pass "Liveness probe" || fail "Liveness"
grep -q 'readinessProbe' "$DELIV/deployment.yaml" && pass "Readiness probe" || fail "Readiness"
grep -q 'RollingUpdate' "$DELIV/deployment.yaml" && pass "Rolling update" || fail "Rolling update"
grep -q '/health' "$DELIV/deployment.yaml" && pass "Health path" || fail "Health path"

[[ -f "$DELIV/KUBECTL_GUIDE.md" ]] && pass "kubectl guide" || fail "Guide"
grep -qiE 'scale|rollout|logs|describe' "$DELIV/KUBECTL_GUIDE.md" && pass "Debug commands" || fail "Debug commands"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }