#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== VPC IAM Security Lab — Solve ==="
mkdir -p "$DELIV/terraform" "$DELIV/iam"
cp -R "$LAB_DIR/solutions/terraform/"* "$DELIV/terraform/"
cp "$LAB_DIR/solutions/iam/"*.json "$DELIV/iam/"
cp "$LAB_DIR/solutions/iam-policy-tests.sh" "$LAB_DIR/solutions/VPC_IAM_GUIDE.md" "$DELIV/"
chmod +x "$DELIV/iam-policy-tests.sh"

if command -v terraform &>/dev/null; then
  (cd "$DELIV/terraform" && terraform fmt -check -recursive 2>/dev/null) || \
    (cd "$DELIV/terraform" && terraform fmt -recursive)
  (cd "$DELIV/terraform" && terraform init -backend=false -input=false >/dev/null 2>&1 && \
    terraform validate 2>&1 | tail -1) || echo "  terraform validate skipped (no provider download)"
fi

echo "→ deliverables/terraform/ + iam/"
echo "Run ./scripts/check.sh"