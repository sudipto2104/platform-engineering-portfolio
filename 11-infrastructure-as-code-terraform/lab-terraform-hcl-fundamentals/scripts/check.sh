#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TF="$LAB_DIR/deliverables/terraform"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Terraform HCL Fundamentals Lab — Check ==="

[[ -f "$TF/versions.tf" ]] && pass "versions.tf" || fail "versions.tf"
[[ -f "$TF/variables.tf" ]] && pass "variables.tf" || fail "variables.tf"
[[ -f "$TF/main.tf" ]] && pass "main.tf" || fail "main.tf"
[[ -f "$TF/outputs.tf" ]] && pass "outputs.tf" || fail "outputs.tf"

grep -q 'validation {' "$TF/variables.tf" && pass "Variable validation" || fail "Validation"
grep -q 'locals {' "$TF/main.tf" && pass "Locals block" || fail "Locals"
grep -q 'aws_vpc' "$TF/main.tf" && pass "VPC resource" || fail "VPC"
grep -q 'output ' "$TF/outputs.tf" && pass "Outputs defined" || fail "Outputs"
grep -qiE 'terraform init|terraform plan|terraform apply' "$LAB_DIR/deliverables/TERRAFORM_BASICS_GUIDE.md" \
  && pass "Workflow guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }