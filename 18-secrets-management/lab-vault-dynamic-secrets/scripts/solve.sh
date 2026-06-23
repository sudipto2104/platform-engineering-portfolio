#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
SRC="$LAB_DIR/solutions"

echo "=== Vault Dynamic Secrets Lab — Solve ==="
mkdir -p "$DELIV"/{vault,policies,scripts,k8s}
cp "$SRC/VAULT_DYNAMIC_SECRETS_GUIDE.md" "$DELIV/"
cp "$SRC/vault/"* "$DELIV/vault/"
cp "$SRC/policies/"*.hcl "$DELIV/policies/"
cp "$SRC/scripts/"*.sh "$DELIV/scripts/"
cp "$SRC/k8s/"*.yaml "$DELIV/k8s/"
chmod +x "$DELIV/scripts/"*.sh

echo "→ deliverables/vault/, policies/, scripts/"
echo "Run ./scripts/check.sh"