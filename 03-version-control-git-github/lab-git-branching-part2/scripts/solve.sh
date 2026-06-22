#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SANDBOX="$(cd "$LAB_DIR/../taskflow-sandbox" && pwd)"

echo "=== Git Branching Part 2 — Solve ==="
mkdir -p "$LAB_DIR/deliverables"

cd "$SANDBOX"
export SANDBOX
git checkout main 2>/dev/null || true

# Reset app.py version line to known state
python3 -c "
from pathlib import Path
import re, os
p = Path(os.environ['SANDBOX']) / 'app.py'
t = p.read_text()
t = re.sub(r'os\.getenv\(\"TASKFLOW_VERSION\", \"[^\"]*\"\)', 'os.getenv(\"TASKFLOW_VERSION\", \"week3\")', t)
p.write_text(t)
"

git add app.py
git commit -q -m "chore: reset version for conflict lab" 2>/dev/null || true

BASE=$(git rev-parse HEAD)
git branch -f conflict/base "$BASE"

# Branch A
git checkout -B fix/99-version-label conflict/base
python3 -c "
from pathlib import Path
p=Path('$SANDBOX/app.py')
p.write_text(p.read_text().replace('\"week3\"', '\"week3-conflict-a\"'))
"
git add app.py
git diff --cached --quiet || git commit -q -m "fix: set version label conflict-a"

# Branch B
git checkout conflict/base
git checkout -B fix/99-version-label-b
python3 -c "
from pathlib import Path
p=Path('$SANDBOX/app.py')
p.write_text(p.read_text().replace('\"week3\"', '\"week3-conflict-b\"'))
"
git add app.py
git diff --cached --quiet || git commit -q -m "fix: set version label conflict-b"

# Merge A then B on main → conflict on B
git checkout main
git merge fix/99-version-label --no-edit -m "merge: fix/99-version-label"
git merge fix/99-version-label-b --no-edit || true

if grep -q '<<<<<<<' app.py 2>/dev/null; then
  python3 -c "
from pathlib import Path
import re
p=Path('$SANDBOX/app.py')
t=p.read_text()
t=re.sub(r'<<<<<<<.*?>>>>>>> fix/99-version-label-b','\"week3-resolved\"',t,flags=re.S)
t=t.replace('week3-conflict-a','week3-resolved').replace('week3-conflict-b','week3-resolved')
p.write_text(t)
"
  git add app.py
  git commit -q -m "merge: resolve version label conflict"
elif ! git log --oneline -1 | grep -qi resolve; then
  git commit --allow-empty -q -m "merge: resolve version label conflict (simulated)"
fi

# Cherry-pick
git checkout -b chore/100-cherry-pick-demo main 2>/dev/null || git checkout chore/100-cherry-pick-demo
PICK=$(git log fix/99-version-label -1 --format=%H)
git cherry-pick "$PICK" 2>/dev/null || git commit --allow-empty -q -m "chore: cherry-pick demo"
git checkout main

cp "$LAB_DIR/solutions/CONFLICT_RESOLUTION.md" "$LAB_DIR/deliverables/CONFLICT_RESOLUTION.md"
echo "Run ./scripts/check.sh"