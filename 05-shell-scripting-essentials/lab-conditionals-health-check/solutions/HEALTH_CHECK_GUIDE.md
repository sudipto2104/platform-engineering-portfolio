# TaskFlow Health Check Guide

## Conditionals used

- `if/elif/else` for disk warning vs critical thresholds
- `[ ]` / `[[ ]]` file tests (`-f`, `-e`, `-r`)
- `case` for interactive menu
- `&&`, `||`, `!` for compound checks

## Validation patterns

- Numeric validation with regex `^[0-9]+$`
- `command -v` for required binaries
- Exit codes: 0 OK, 1 warn, 2 critical

## Run

```bash
BATCH_MODE=1 ./health_check.sh workspace/thresholds.env
```