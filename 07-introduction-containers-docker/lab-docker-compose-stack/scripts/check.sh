#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"
STACK="$LAB_DIR/../taskflow-stack"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Docker Compose Stack Lab — Check ==="

[[ -f "$DELIV/docker-compose.yml" ]] && pass "docker-compose.yml" || fail "compose file"
grep -q 'postgres:' "$DELIV/docker-compose.yml" && pass "PostgreSQL service" || fail "PostgreSQL"
grep -q 'redis:' "$DELIV/docker-compose.yml" && pass "Redis service" || fail "Redis"
grep -q 'backend:' "$DELIV/docker-compose.yml" && pass "Backend service" || fail "Backend"
grep -q 'frontend:' "$DELIV/docker-compose.yml" && pass "Frontend service" || fail "Frontend"
grep -q 'taskflow_pg_data' "$DELIV/docker-compose.yml" && pass "PG named volume" || fail "PG volume"
grep -q 'taskflow_redis_data' "$DELIV/docker-compose.yml" && pass "Redis named volume" || fail "Redis volume"
grep -q 'healthcheck' "$DELIV/docker-compose.yml" && pass "Health checks" || fail "Health checks"
grep -q 'depends_on' "$DELIV/docker-compose.yml" && pass "Service dependencies" || fail "Dependencies"

[[ -x "$DELIV/backup-volumes.sh" ]] && pass "Backup script" || fail "Backup"
[[ -x "$DELIV/restore-volumes.sh" ]] && pass "Restore script" || fail "Restore"
grep -q 'EnvBanner\|VITE_APP_ENV' "$STACK/frontend/src/components/EnvBanner.vue" && pass "Env banner UI" || fail "Env banner"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }