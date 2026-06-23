# CLI Tools Guide — Click vs Typer for TaskFlow

## Overview

Production-ready CLI tools are the backbone of platform self-service. This lab implements the same TaskFlow commands in **Click** and **Typer** so you can choose the right framework.

## Commands

| Command | Purpose |
|---------|---------|
| `deploy` | Deploy TaskFlow to k8s, ec2, or local |
| `status` | Show environment, namespace, API health |
| `logs` | Tail service logs |
| `config` | Load and display YAML configuration |

## Click (imperative decorators)

```bash
cd deliverables
python -m taskflow_cli_click --help
python -m taskflow_cli_click deploy --target k8s
python -m taskflow_cli_click status --namespace taskflow
python -m taskflow_cli_click config --show
```

Click uses `@click.group()` + `@cli.command()` with `@click.pass_context` for shared state.

## Typer (type-hint driven)

```bash
python -m taskflow_cli_typer --help
python -m taskflow_cli_typer deploy --target k8s
python -m taskflow_cli_typer status --namespace taskflow
python -m taskflow_cli_typer config --show
```

Typer infers CLI options from Python type hints and `Annotated` metadata.

## Configuration

Copy and customize:

```bash
cp config/taskflow.yaml.example config/taskflow.yaml
export TASKFLOW_CONFIG=deliverables/config/taskflow.yaml
export TASKFLOW_ENV=staging
```

Environment variables override YAML values — production pattern for 12-factor apps.

## Click vs Typer

| Feature | Click | Typer |
|---------|-------|-------|
| Style | Decorators | Type hints |
| Subcommands | `@click.group()` | `typer.Typer()` |
| Help text | `help=` on decorators | Docstrings + `Annotated` |
| Ecosystem | Mature, widely used | Built on Click, modern DX |

## Platform integration

Wire these CLIs into:

- **Backstage templates** (Week 13) — `fetch:template` includes CLI
- **Kubernetes workflows** (Lab 2) — `deploy` calls `taskflow_k8s`
- **AWS automation** (Lab 1) — `deploy --target ec2` calls `taskflow_aws`

## Verify

```bash
./scripts/check.sh
python -m py_compile taskflow_cli_click/*.py taskflow_cli_typer/*.py
```