# Functions & Libraries Guide

## Patterns

- `source lib/logging.sh` — import shared helpers
- `local` variables inside functions for scope isolation
- Return codes via `return` and `set -euo pipefail`
- `retry 3 curl ...` for resilient automation

## Library layout

```
lib/
  logging.sh   # log_info, log_warn, log_error
  common.sh    # require_cmd, assert_file, retry
deploy_module.sh
```

## Test

```bash
./deploy_module.sh staging
```