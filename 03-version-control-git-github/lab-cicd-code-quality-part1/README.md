# Lab: CI/CD Code Quality Part 1

Quality gates for TaskFlow: **Ruff** (lint), **Black** (format), **pip-audit** (security), plus **ESLint/Prettier/npm audit** for the JS stub.

## TaskFlow mapping

| Bootcamp tool | TaskFlow stack |
|---------------|----------------|
| ESLint | Ruff (`frontend/` uses ESLint) |
| Prettier | Black + Prettier |
| npm audit | pip-audit + npm audit |

## Verify

```bash
./scripts/solve.sh && ./scripts/check.sh
```