# Quality Gates — TaskFlow (Reference)

## Local checks

```bash
# Python
ruff check app.py
black --check app.py
pip-audit -r requirements.txt

# JavaScript stub
cd frontend && npm ci
npm run lint
npm run format
npm audit --audit-level=high
```

## CI workflow

`.github/workflows/quality.yml` runs on every PR to `main`.

## Branch protection (GitHub UI)

Settings → Branches → Add rule for `main`:

- [x] Require status checks: `python-quality`, `javascript-quality`
- [x] Require PR before merging
- [x] Dismiss stale reviews

Documented in detail in Part 2.