#!/usr/bin/env bash
# Prototype: parse a mock ticket export and summarize repetitive ops toil.
set -euo pipefail

readonly SCRIPT_NAME="toil-ticket-report"
readonly INPUT="${1:-$(dirname "$0")/../data/sample_tickets.csv}"
readonly LOG_DIR="${LOG_DIR:-/tmp/apex-automation}"
readonly LOG_FILE="$LOG_DIR/${SCRIPT_NAME}.log"

mkdir -p "$LOG_DIR"

log() {
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [$SCRIPT_NAME] $*" | tee -a "$LOG_FILE"
}

[[ -f "$INPUT" ]] || { log "ERROR missing input $INPUT"; exit 2; }

log "INFO analyzing $INPUT"

python3 <<PY
import csv
from collections import Counter
from pathlib import Path

path = Path("$INPUT")
with path.open() as f:
    rows = list(csv.DictReader(f))

categories = Counter(r["category"] for r in rows)
print("=== Toil Report ===")
print(f"Total tickets: {len(rows)}")
print("Top categories:")
for cat, n in categories.most_common(5):
    pct = 100 * n / len(rows)
    print(f"  {cat}: {n} ({pct:.0f}%)")
automate = [c for c, n in categories.items() if n >= 3]
print(f"Automation candidates (3+ tickets): {', '.join(automate) or 'none'}")
PY

log "INFO report complete"