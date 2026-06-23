#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
PKG="$DELIV/taskflow_monitor_agent"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Monitoring Agent Self-Healing Lab — Check ==="

[[ -f "$DELIV/requirements.txt" ]] && pass "requirements.txt" || fail "requirements.txt"
grep -q 'prometheus_client\|requests' "$DELIV/requirements.txt" && pass "Dependencies" || fail "Dependencies"

for mod in agent metrics remediation thresholds; do
  [[ -f "$PKG/${mod}.py" ]] && pass "${mod}.py" || fail "${mod}.py"
done
[[ -f "$DELIV/k8s/agent-deployment.yaml" ]] && pass "Agent deployment" || fail "Agent deployment"

grep -q 'prometheus_client\|Gauge\|Counter' "$PKG/metrics.py" && pass "Prometheus metrics" || fail "Prometheus metrics"
grep -q 'threshold\|evaluate' "$PKG/thresholds.py" && pass "Threshold evaluation" || fail "Threshold evaluation"
grep -q 'remediat\|restart\|scale' "$PKG/remediation.py" && pass "Remediation actions" || fail "Remediation actions"
grep -q 'self.heal\|remediat\|incident' "$PKG/agent.py" && pass "Self-healing loop" || fail "Self-healing loop"
grep -q 'livenessProbe\|taskflow-monitor' "$DELIV/k8s/agent-deployment.yaml" && pass "K8s agent manifest" || fail "K8s agent manifest"
grep -qiE 'self-heal|remediation|incident' "$DELIV/MONITORING_AGENT_GUIDE.md" && pass "Self-healing guide" || fail "Self-healing guide"
grep -qiE 'prometheus|threshold|automated' "$DELIV/MONITORING_AGENT_GUIDE.md" && pass "Agent guide" || fail "Agent guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }