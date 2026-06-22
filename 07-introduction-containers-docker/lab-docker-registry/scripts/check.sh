#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DELIV="$LAB_DIR/deliverables"

PASS=0; FAIL=0
pass() { echo "✓ $1"; PASS=$((PASS+1)); }
fail() { echo "✗ $1"; FAIL=$((FAIL+1)); }

echo "=== Docker Registry Lab — Check ==="

[[ -x "$DELIV/tag-images.sh" ]] && pass "tag-images.sh" || fail "tag-images"
[[ -x "$DELIV/push-images.sh" ]] && pass "push-images.sh" || fail "push-images"
[[ -x "$DELIV/pull-images.sh" ]] && pass "pull-images.sh" || fail "pull-images"
[[ -f "$DELIV/docker-compose.registry.yml" ]] && pass "Local registry compose" || fail "Registry compose"

grep -q 'docker tag' "$DELIV/tag-images.sh" && pass "Tag workflow" || fail "Tag workflow"
grep -q 'docker push\|MOCK_MODE' "$DELIV/push-images.sh" && pass "Push workflow" || fail "Push"
grep -q 'docker pull\|docker load' "$DELIV/pull-images.sh" && pass "Pull workflow" || fail "Pull"
grep -qiE 'v1\.0\.0|semantic|latest' "$DELIV/REGISTRY_GUIDE.md" && pass "Versioning docs" || fail "Versioning"
grep -qiE 'kubernetes|week 8|registry' "$DELIV/REGISTRY_GUIDE.md" && pass "K8s prep notes" || fail "K8s prep"

echo "Results: $PASS passed, $FAIL failed"
[[ "$FAIL" -eq 0 ]] || { echo "Run ./scripts/solve.sh"; exit 1; }