#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Grafana Dashboards Lab — Check ==="

[[ -f "$DELIV/grafana/dashboards/taskflow-overview.json" ]] && pass "Overview dashboard" || fail "Overview dashboard"
[[ -f "$DELIV/grafana/provisioning/dashboards.yaml" ]] && pass "Dashboard provisioning" || fail "Dashboard provisioning"
[[ -f "$DELIV/grafana/provisioning/datasources.yaml" ]] && pass "Datasource provisioning" || fail "Datasource provisioning"

grep -q '"templating"' "$DELIV/grafana/dashboards/taskflow-overview.json" && pass "Template variables" || fail "Template variables"
grep -q 'environment\|namespace' "$DELIV/grafana/dashboards/taskflow-overview.json" && pass "Environment variable" || fail "Environment variable"
grep -q 'taskflow_api_healthy\|taskflow_tasks' "$DELIV/grafana/dashboards/taskflow-overview.json" && pass "TaskFlow panels" || fail "TaskFlow panels"
grep -q 'prometheus' "$DELIV/grafana/provisioning/datasources.yaml" && pass "Prometheus datasource" || fail "Prometheus datasource"
grep -q 'providers\|path' "$DELIV/grafana/provisioning/dashboards.yaml" && pass "Dashboard provider" || fail "Dashboard provider"
grep -qiE 'grafana|dashboard|variable' "$DELIV/GRAFANA_DASHBOARDS_GUIDE.md" && pass "Grafana guide" || fail "Grafana guide"
grep -qiE 'templat|provision' "$DELIV/GRAFANA_DASHBOARDS_GUIDE.md" && pass "Provisioning guide" || fail "Provisioning guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }