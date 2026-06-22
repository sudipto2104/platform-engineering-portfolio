#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Ingress TLS HPA Lab — Check ==="

[[ -f "$DELIV/ingress.yaml" ]] && pass "Ingress manifest" || fail "Ingress"
grep -q 'ingressClassName: nginx' "$DELIV/ingress.yaml" && pass "Nginx ingress class" || fail "Ingress class"
grep -q 'tls:' "$DELIV/ingress.yaml" && pass "TLS block" || fail "TLS"
[[ -f "$DELIV/certificate.yaml" ]] && pass "cert-manager Certificate" || fail "Certificate"
[[ -f "$DELIV/hpa-api.yaml" && -f "$DELIV/hpa-ui.yaml" ]] && pass "HPA manifests" || fail "HPA"
grep -q 'HorizontalPodAutoscaler' "$DELIV/hpa-api.yaml" && pass "HPA API" || fail "HPA API"
grep -q 'averageUtilization' "$DELIV/hpa-api.yaml" && pass "CPU/memory metrics" || fail "Metrics"
grep -q 'maxReplicas' "$DELIV/hpa-api.yaml" && pass "Autoscale bounds" || fail "Scale bounds"
grep -qiE 'ingress-nginx|metrics-server|cert-manager' "$DELIV/INGRESS_HPA_GUIDE.md" && pass "Ops guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }