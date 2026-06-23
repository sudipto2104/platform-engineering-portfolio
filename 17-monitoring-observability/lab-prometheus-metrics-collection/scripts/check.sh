#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Prometheus Metrics Collection Lab — Check ==="

[[ -f "$DELIV/prometheus/prometheus.yml" ]] && pass "prometheus.yml" || fail "prometheus.yml"
[[ -f "$DELIV/prometheus/alert-rules.yml" ]] && pass "alert-rules.yml" || fail "alert-rules.yml"
[[ -f "$DELIV/exporters/taskflow_exporter.py" ]] && pass "TaskFlow exporter" || fail "TaskFlow exporter"
[[ -f "$DELIV/promql/PROMQL_QUERIES.md" ]] && pass "PromQL reference" || fail "PromQL reference"
[[ -f "$DELIV/k8s/servicemonitor-taskflow.yaml" ]] && pass "ServiceMonitor" || fail "ServiceMonitor"

grep -q 'scrape_configs' "$DELIV/prometheus/prometheus.yml" && pass "Scrape configs" || fail "Scrape configs"
grep -q 'kubernetes_sd_configs\|kubernetes-pods' "$DELIV/prometheus/prometheus.yml" && pass "K8s service discovery" || fail "K8s service discovery"
grep -q 'retention\|storage.tsdb' "$DELIV/prometheus/prometheus.yml" && pass "Retention policy" || fail "Retention policy"
grep -q 'prometheus_client\|Counter\|Gauge\|Histogram' "$DELIV/exporters/taskflow_exporter.py" && pass "Custom metrics" || fail "Custom metrics"
grep -q 'rate(\|histogram_quantile\|up{' "$DELIV/promql/PROMQL_QUERIES.md" && pass "PromQL queries" || fail "PromQL queries"
grep -q 'ServiceMonitor\|prometheus.io' "$DELIV/k8s/servicemonitor-taskflow.yaml" && pass "K8s monitoring" || fail "K8s monitoring"
grep -qiE 'prometheus|exporter|promql' "$DELIV/PROMETHEUS_GUIDE.md" && pass "Prometheus guide" || fail "Prometheus guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }