#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

echo "=== Git Fundamentals Part 1 — Solve ==="
mkdir -p "$LAB_DIR/deliverables"

cd "$SANDBOX"
if [[ ! -d .git ]]; then
  git init -q
fi
git config user.email "${GIT_AUTHOR_EMAIL:-student@taskflow.local}"
git config user.name "${GIT_AUTHOR_NAME:-TaskFlow Student}"
git config init.defaultBranch main

git add README.md app.py requirements.txt .gitignore
if ! git diff --cached --quiet 2>/dev/null; then
  git commit -q -m "feat: initial TaskFlow week3 sandbox"
fi
git branch -M main 2>/dev/null || true

if [[ "$(git rev-list --count HEAD 2>/dev/null || echo 0)" -lt 2 ]]; then
  echo "" >> README.md
  echo "_Week 3 Git practice commit marker._" >> README.md
  git add README.md
  git commit -q -m "docs: note week3 git practice"
fi

cp "$LAB_DIR/solutions/GIT_SETUP_LOG.md" "$LAB_DIR/deliverables/GIT_SETUP_LOG.md"
{
  echo ""
  echo "## Live log ($(date -u +%Y-%m-%dT%H:%M:%SZ))"
  echo '```'
  git log --oneline -5
  echo '```'
} >> "$LAB_DIR/deliverables/GIT_SETUP_LOG.md"

echo "→ sandbox commits: $(git rev-list --count HEAD)"
echo "Run ./scripts/check.sh"