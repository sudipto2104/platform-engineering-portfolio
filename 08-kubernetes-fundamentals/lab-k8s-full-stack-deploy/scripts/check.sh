#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
K8S="$LAB_DIR/../taskflow-k8s"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== K8s Full Stack Deploy Lab — Check ==="

grep -q 'name: taskflow$' "$DELIV/00-namespace.yaml" && pass "taskflow namespace" || fail "namespace"
[[ -f "$DELIV/03-postgres.yaml" && -f "$DELIV/04-redis.yaml" ]] && pass "Data tier manifests" || fail "Data tier"
[[ -f "$DELIV/05-backend.yaml" && -f "$DELIV/06-frontend.yaml" ]] && pass "App tier manifests" || fail "App tier"
grep -q 'NodePort' "$DELIV/06-frontend.yaml" && pass "NodePort frontend" || fail "NodePort"
grep -q 'nodePort: 30080' "$DELIV/06-frontend.yaml" && pass "Browser port 30080" || fail "Port 30080"
grep -q 'DATABASE_URL' "$DELIV/05-backend.yaml" && pass "DB env injection" || fail "DB env"
grep -q 'StatefulSet' "$DELIV/03-postgres.yaml" && pass "Postgres StatefulSet" || fail "StatefulSet"

grep -q 'on_event\|DATABASE_URL' "$K8S/backend/main.py" && pass "Backend DNS logging" || fail "Backend logging"
[[ -f "$DELIV/KUBECTL_RUNBOOK.md" ]] && pass "kubectl runbook" || fail "Runbook"
grep -qiE 'dns|nslookup|minikube service' "$DELIV/KUBECTL_RUNBOOK.md" && pass "E2E verify docs" || fail "E2E docs"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }