#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
TF="$DELIV/terraform"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== VPC IAM Security Lab — Check ==="

[[ -f "$TF/vpc.tf" ]] && pass "vpc.tf" || fail "vpc.tf"
[[ -f "$TF/iam.tf" ]] && pass "iam.tf" || fail "iam.tf"
[[ -f "$TF/security.tf" ]] && pass "security.tf" || fail "security.tf"
grep -q 'aws_internet_gateway' "$TF/vpc.tf" && pass "Internet Gateway" || fail "IGW"
grep -q 'aws_nat_gateway' "$TF/vpc.tf" && pass "NAT Gateway" || fail "NAT"
grep -q 'private_app' "$TF/vpc.tf" && pass "Private app subnets" || fail "App subnets"
grep -q 'private_data' "$TF/vpc.tf" && pass "Private data subnets" || fail "Data subnets"
grep -q '10.30' "$TF/variables.tf" && pass "Week 4 CIDR" || fail "CIDR"

grep -q 'aws_iam_role' "$TF/iam.tf" && pass "IAM roles" || fail "IAM roles"
grep -q 'instance_profile' "$TF/iam.tf" && pass "Instance profile" || fail "Profile"
[[ -f "$DELIV/iam/taskflow-ec2-policy.json" ]] && pass "EC2 policy JSON" || fail "Policy JSON"
[[ -x "$DELIV/iam-policy-tests.sh" ]] && pass "Policy tests script" || fail "Policy tests"

grep -qiE 'least.privilege|NAT|security.group' "$DELIV/VPC_IAM_GUIDE.md" && pass "Architecture guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }