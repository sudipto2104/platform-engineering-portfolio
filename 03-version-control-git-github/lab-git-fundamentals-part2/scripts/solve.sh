#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"
BARE="$LAB_DIR/workspace/taskflow-remote.git"
CLONE="$LAB_DIR/workspace/taskflow-clone"

echo "=== Git Fundamentals Part 2 — Solve ==="
mkdir -p "$LAB_DIR/deliverables" "$LAB_DIR/workspace"

"$LAB_DIR/../lab-git-fundamentals-part1/scripts/solve.sh" 2>/dev/null || true

cd "$SANDBOX"
git branch -M main 2>/dev/null || true

rm -rf "$BARE" "$CLONE"
git init --bare -q "$BARE"
git remote remove origin 2>/dev/null || true
git remote add origin "$BARE"
git push -u origin main

git clone -q "$BARE" "$CLONE"
cd "$CLONE"
git checkout main
echo "# remote edit" >> README.md
git add README.md
git commit -q -m "docs: remote README tweak"
git push origin main

cd "$SANDBOX"
git fetch origin
git merge origin/main --no-edit -m "merge: pull remote README tweak"

cp "$LAB_DIR/solutions/HISTORY_REPORT.md" "$LAB_DIR/deliverables/HISTORY_REPORT.md"
{
  echo ""
  echo "## git log --oneline -5"
  echo '```'
  git log --oneline -5
  echo '```'
  echo "## git blame app.py (first 5 lines)"
  echo '```'
  git blame -L 1,5 app.py
  echo '```'
} >> "$LAB_DIR/deliverables/HISTORY_REPORT.md"

echo "→ remote simulated at workspace/taskflow-remote.git"
echo "Run ./scripts/check.sh"