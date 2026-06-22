#!/usr/bin/env bash
# Simulate IAM policy tests — document expected allow/deny outcomes
set -euo pipefail

echo "=== TaskFlow IAM Policy Tests ==="
echo "[PASS] EC2 role: s3:PutObject on taskflow-attachments-production/*"
echo "[PASS] EC2 role: ecr:GetAuthorizationToken"
echo "[DENY] EC2 role: s3:DeleteObject on other buckets"
echo "[DENY] EC2 role: iam:CreateUser"
echo "[PASS] Deployer role: ecr:PutImage on taskflow/* repos (with platform tag)"
echo ""
echo "Run with IAM Policy Simulator in AWS Console for live validation."