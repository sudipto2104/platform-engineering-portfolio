#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Network Architecture Lab — Check ==="

[[ -f "$LAB_DIR/templates/vpc-template.yaml" ]] && pass "VPC template" || fail "VPC template"
[[ -f "$DELIV/ARCHITECTURE_DECISIONS.md" ]] && pass "Architecture decisions" || fail "Architecture decisions"

for env in dev staging production; do
  [[ -f "$DELIV/environments/${env}.yaml" ]] && pass "${env}.yaml" || fail "${env}.yaml"
done

grep -qiE "10\.10|10\.20|10\.30|/16" "$DELIV/ARCHITECTURE_DECISIONS.md" \
  && pass "Non-overlapping VPC CIDRs" || fail "VPC CIDR planning"

grep -qiE "web|app|data|tier|subnet" "$DELIV/ARCHITECTURE_DECISIONS.md" \
  && pass "3-tier design documented" || fail "3-tier design"

grep -qiE "security.group|NACL|route" "$DELIV/ARCHITECTURE_DECISIONS.md" \
  && pass "Security and routing" || fail "Security and routing"

grep -q "cidr:" "$DELIV/environments/production.yaml" \
  && pass "Production YAML structure" || fail "Production YAML"

grep -q "tier: database" "$DELIV/environments/dev.yaml" \
  && pass "Data tier subnet" || fail "Data tier subnet"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }