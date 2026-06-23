# Lab: CLI Tools with Click & Typer

Build production-ready CLI tools for TaskFlow DevOps automation using Click and Typer.

## What you build

- `taskflow_cli_click/` — multi-command Click application
- `taskflow_cli_typer/` — equivalent Typer application
- YAML configuration loading with environment overrides
- Commands: `deploy`, `status`, `logs`, `config`

## Quick start

```bash
./scripts/solve.sh && ./scripts/check.sh
pip install -r deliverables/requirements.txt
python -m taskflow_cli_click --help
python -m taskflow_cli_typer --help
```