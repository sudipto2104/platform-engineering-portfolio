#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== AlertManager Routing Lab — Check ==="

[[ -f "$DELIV/alertmanager/alertmanager.yml" ]] && pass "alertmanager.yml" || fail "alertmanager.yml"
[[ -f "$DELIV/prometheus/alert-rules-production.yml" ]] && pass "Production alert rules" || fail "Production alert rules"

grep -q 'route:' "$DELIV/alertmanager/alertmanager.yml" && pass "Routing config" || fail "Routing config"
grep -q 'receivers:' "$DELIV/alertmanager/alertmanager.yml" && pass "Receivers" || fail "Receivers"
grep -q 'slack\|email\|pagerduty' "$DELIV/alertmanager/alertmanager.yml" && pass "Notification channels" || fail "Notification channels"
grep -q 'inhibit_rules\|continue' "$DELIV/alertmanager/alertmanager.yml" && pass "Advanced routing" || fail "Advanced routing"
grep -q 'severity: critical' "$DELIV/prometheus/alert-rules-production.yml" && pass "Critical alerts" || fail "Critical alerts"
grep -q 'severity: warning' "$DELIV/prometheus/alert-rules-production.yml" && pass "Warning alerts" || fail "Warning alerts"
grep -q 'alert:' "$DELIV/prometheus/alert-rules-production.yml" && pass "Alert definitions" || fail "Alert definitions"
grep -qiE 'alertmanager|routing|notification' "$DELIV/ALERTMANAGER_GUIDE.md" && pass "AlertManager guide" || fail "AlertManager guide"
grep -qiE 'severity|inhibit|pagerduty' "$DELIV/ALERTMANAGER_GUIDE.md" && pass "Advanced alerting guide" || fail "Advanced alerting guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }