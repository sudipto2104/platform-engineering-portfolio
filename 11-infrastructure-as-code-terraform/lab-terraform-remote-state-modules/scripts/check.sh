#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Remote State & Modules Lab — Check ==="

[[ -f "$DELIV/bootstrap/backend-resources.tf" ]] && pass "Bootstrap config" || fail "Bootstrap"
grep -q 'aws_dynamodb_table' "$DELIV/bootstrap/backend-resources.tf" && pass "DynamoDB locks" || fail "DynamoDB"
grep -q 'aws_s3_bucket' "$DELIV/bootstrap/backend-resources.tf" && pass "S3 state bucket" || fail "S3 state"

[[ -f "$DELIV/modules/vpc/main.tf" ]] && pass "VPC module" || fail "VPC module"
[[ -f "$DELIV/modules/s3/main.tf" ]] && pass "S3 module" || fail "S3 module"
grep -q 'module "vpc"' "$DELIV/environments/dev/main.tf" && pass "Module composition" || fail "Composition"
grep -q 'backend "s3"' "$DELIV/environments/dev/main.tf" && pass "S3 backend" || fail "S3 backend"
grep -q 'dynamodb_table' "$DELIV/environments/dev/main.tf" && pass "State locking" || fail "Locking"

grep -qiE 'remote state|module' "$DELIV/REMOTE_STATE_GUIDE.md" && pass "Guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }