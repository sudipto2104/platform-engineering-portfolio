#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

echo "=== Git Branching Part 1 — Solve ==="
mkdir -p "$LAB_DIR/deliverables"

"$LAB_DIR/../lab-git-fundamentals-part1/scripts/solve.sh" 2>/dev/null || true

cd "$SANDBOX"
git checkout main 2>/dev/null || git checkout -b main

# Stash demo
echo "# WIP notes" > WIP.txt
git add WIP.txt 2>/dev/null || true
git stash push -m "wip: task filters notes" -- WIP.txt 2>/dev/null || git stash push -m "wip: notes" || true
rm -f WIP.txt

# Feature branch
git checkout -b feature/12-add-task-count 2>/dev/null || git checkout feature/12-add-task-count
if ! grep -q "week3-branch" app.py; then
  sed -i.bak 's/week3/week3-branch/' app.py 2>/dev/null || \
    python3 -c "
from pathlib import Path
p=Path('app.py')
p.write_text(p.read_text().replace('week3','week3-branch'))
"
  rm -f app.py.bak
  git add app.py
  git commit -q -m "feat: expose week3-branch version in health"
fi

git checkout main
git merge --no-ff feature/12-add-task-count -m "merge: feature/12-add-task-count"

cp "$LAB_DIR/solutions/BRANCHING_LOG.md" "$LAB_DIR/deliverables/BRANCHING_LOG.md"
{
  echo ""
  echo "## Branches"
  echo '```'
  git branch -a
  echo '```'
  echo "## Stash list"
  echo '```'
  git stash list || true
  echo '```'
} >> "$LAB_DIR/deliverables/BRANCHING_LOG.md"

echo "Run ./scripts/check.sh"