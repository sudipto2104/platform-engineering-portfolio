# Branch Protection — TaskFlow (Reference)

## GitHub settings (main branch)

| Rule | Value |
|------|--------|
| Require PR before merging | ✅ |
| Required checks | `python-quality`, `javascript-quality` |
| Require branches up to date | ✅ |
| Include administrators | ✅ |
| Restrict force push | ✅ |

## Enforcing npm audit

In `quality.yml` Part 2 — remove `|| true` from audit steps so merges block on high vulnerabilities.

## Test the gate (intentional break)

```bash
# Introduce lint error
echo "const x = " >> frontend/stub.js
npm run lint   # should fail

# Fix
git checkout frontend/stub.js
```

## pip-audit enforcement

```bash
pip-audit -r requirements.txt --strict
```

Fails CI when known CVEs exist in dependencies.

## Recovery workflow

1. Fix locally
2. Push branch
3. Wait for green checks
4. Squash merge PR