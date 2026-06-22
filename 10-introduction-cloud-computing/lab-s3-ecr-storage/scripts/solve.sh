#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

echo "=== S3 ECR Storage Lab — Solve ==="
mkdir -p "$DELIV"
cp "$LAB_DIR/solutions/s3_attachments.py" "$LAB_DIR/solutions/ecr-migrate.sh" \
   "$LAB_DIR/solutions/iam-taskflow-ec2-role.json" "$LAB_DIR/solutions/S3_ECR_GUIDE.md" "$DELIV/"
chmod +x "$DELIV/ecr-migrate.sh"

python3 -c "import ast; ast.parse(open('$DELIV/s3_attachments.py').read())" && echo "  s3_attachments.py syntax OK"

echo "→ deliverables/s3_attachments.py, ecr-migrate.sh, IAM policy"
echo "Run ./scripts/check.sh"