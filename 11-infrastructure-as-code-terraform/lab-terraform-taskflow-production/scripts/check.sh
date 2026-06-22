#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
PROD="$DELIV/environments/production/main.tf"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== TaskFlow Production Terraform Lab — Check ==="

for mod in vpc ec2 rds elasticache s3 iam; do
  [[ -f "$DELIV/modules/$mod/main.tf" ]] && pass "$mod module" || fail "$mod module"
done

[[ -f "$PROD" ]] && pass "Production root" || fail "Production root"
grep -q 'module "vpc"' "$PROD" && pass "VPC module wired" || fail "VPC wiring"
grep -q 'module "app"' "$PROD" && pass "EC2 module wired" || fail "EC2 wiring"
grep -q 'module "database"' "$PROD" && pass "RDS module wired" || fail "RDS wiring"
grep -q 'module "cache"' "$PROD" && pass "ElastiCache module wired" || fail "ElastiCache wiring"
grep -q 'module "attachments"' "$PROD" && pass "S3 module wired" || fail "S3 wiring"
grep -q 'module "iam"' "$PROD" && pass "IAM module wired" || fail "IAM wiring"

grep -q 'private_data_subnet_ids' "$PROD" && pass "Data subnets referenced" || fail "Data subnets"
grep -q 'module.iam.instance_profile_name' "$PROD" && pass "IAM profile on EC2" || fail "IAM profile"
grep -q 'module.attachments.bucket_arn' "$PROD" && pass "S3 ARN to IAM" || fail "S3 IAM link"
grep -q '10.30.0.0/16' "$DELIV/environments/production/variables.tf" && pass "Production CIDR" || fail "CIDR"
grep -q 'backend "s3"' "$PROD" && pass "Remote state backend" || fail "Backend"
grep -q 'dynamodb_table' "$PROD" && pass "State locking" || fail "Locking"

grep -qiE 'terraform apply' "$DELIV/PRODUCTION_DEPLOY_GUIDE.md" && pass "Deploy guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }