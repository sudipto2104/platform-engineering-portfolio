#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TASKFLOW_DIR="$(cd "$PROJECT_DIR/../taskflow" && pwd)"
DELIV="$PROJECT_DIR/deliverables"

echo "=== TaskFlow Documentation Project — Solve ==="

mkdir -p "$DELIV/docs"

cp "$PROJECT_DIR/examples/README.md" "$DELIV/README.md"
cp "$PROJECT_DIR/examples/CONTRIBUTING.md" "$DELIV/CONTRIBUTING.md"
cp "$PROJECT_DIR/examples/docs/ARCHITECTURE.md" "$DELIV/docs/ARCHITECTURE.md"
cp "$PROJECT_DIR/examples/docs/API.md" "$DELIV/docs/API.md"
echo "→ deliverables/ populated"

mkdir -p "$TASKFLOW_DIR/docs"
cp "$DELIV/README.md" "$TASKFLOW_DIR/README.md"
cp "$DELIV/CONTRIBUTING.md" "$TASKFLOW_DIR/CONTRIBUTING.md"
cp "$DELIV/docs/ARCHITECTURE.md" "$TASKFLOW_DIR/docs/ARCHITECTURE.md"
cp "$DELIV/docs/API.md" "$TASKFLOW_DIR/docs/API.md"
echo "→ published to ../taskflow/"

echo
echo "Customize docs, then run ./scripts/check.sh"