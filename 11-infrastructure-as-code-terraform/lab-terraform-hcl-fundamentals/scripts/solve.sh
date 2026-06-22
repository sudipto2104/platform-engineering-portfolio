#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== Terraform HCL Fundamentals Lab — Solve ==="
mkdir -p "$DELIV/terraform"
cp -R "$LAB_DIR/solutions/terraform/"* "$DELIV/terraform/"
cp "$LAB_DIR/solutions/TERRAFORM_BASICS_GUIDE.md" "$DELIV/"

if command -v terraform &>/dev/null; then
  (cd "$DELIV/terraform" && terraform fmt -recursive && \
    terraform init -backend=false -input=false >/dev/null 2>&1 && terraform validate) 2>&1 | tail -1 || true
fi

echo "→ deliverables/terraform/"
echo "Run ./scripts/check.sh"