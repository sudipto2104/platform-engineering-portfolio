#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== S3 ECR Storage Lab — Check ==="

[[ -f "$DELIV/s3_attachments.py" ]] && pass "boto3 module" || fail "boto3"
[[ -x "$DELIV/ecr-migrate.sh" ]] && pass "ECR migrate script" || fail "ECR script"
[[ -f "$DELIV/iam-taskflow-ec2-role.json" ]] && pass "IAM policy" || fail "IAM"

grep -q 'boto3' "$DELIV/s3_attachments.py" && pass "boto3 import" || fail "boto3 import"
grep -q 'upload_file\|upload_attachment' "$DELIV/s3_attachments.py" && pass "S3 upload" || fail "S3 upload"
grep -q 'ecr get-login-password\|ecr create-repository' "$DELIV/ecr-migrate.sh" && pass "ECR workflow" || fail "ECR"
grep -q 's3:PutObject' "$DELIV/iam-taskflow-ec2-role.json" && pass "S3 IAM" || fail "S3 IAM"
grep -q 'ecr:GetAuthorizationToken' "$DELIV/iam-taskflow-ec2-role.json" && pass "ECR IAM" || fail "ECR IAM"
grep -qiE 'instance profile|boto3' "$DELIV/S3_ECR_GUIDE.md" && pass "Guide" || fail "Guide"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }