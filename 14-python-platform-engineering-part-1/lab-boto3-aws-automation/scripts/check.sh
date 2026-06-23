#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
PKG="$DELIV/taskflow_aws"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Boto3 AWS Automation Lab — Check ==="

[[ -f "$DELIV/requirements.txt" ]] && pass "requirements.txt" || fail "requirements.txt"
grep -q 'boto3' "$DELIV/requirements.txt" && pass "boto3 dependency" || fail "boto3 dependency"

for mod in config ec2_ops s3_ops cloudwatch_ops lambda_ops; do
  [[ -f "$PKG/${mod}.py" ]] && pass "${mod}.py" || fail "${mod}.py"
done

grep -q 'boto3' "$PKG/ec2_ops.py" && pass "EC2 boto3 client" || fail "EC2 boto3 client"
grep -q 'describe_instances\|start_instances\|stop_instances' "$PKG/ec2_ops.py" && pass "EC2 operations" || fail "EC2 operations"
grep -q 'upload_file\|list_objects' "$PKG/s3_ops.py" && pass "S3 operations" || fail "S3 operations"
grep -q 'put_metric_data\|put_metric_alarm\|cloudwatch' "$PKG/cloudwatch_ops.py" && pass "CloudWatch operations" || fail "CloudWatch operations"
grep -q 'invoke\|lambda' "$PKG/lambda_ops.py" && pass "Lambda operations" || fail "Lambda operations"
grep -q 'ClientError\|botocore' "$PKG/ec2_ops.py" && pass "Error handling" || fail "Error handling"
grep -q 'TASKFLOW\|taskflow' "$PKG/config.py" && pass "TaskFlow config" || fail "TaskFlow config"
grep -qiE 'ec2|s3|cloudwatch|lambda' "$DELIV/BOTO3_AWS_GUIDE.md" && pass "AWS guide" || fail "AWS guide"
grep -qiE 'instance profile|credentials|region' "$DELIV/BOTO3_AWS_GUIDE.md" && pass "Production patterns" || fail "Production patterns"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }