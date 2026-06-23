"""TaskFlow platform CLI — Typer implementation."""

from __future__ import annotations

import json
from enum import Enum
from pathlib import Path
from typing import Annotated, Optional

import typer

from .config_loader import load_config

app = typer.Typer(help="TaskFlow platform engineering CLI (Typer)")
state: dict = {}


def _cfg() -> dict:
    return state.get("config", load_config())


@app.callback()
def main(
    config: Annotated[
        Optional[Path], typer.Option("--config", help="Config YAML path")
    ] = None,
) -> None:
    state["config"] = load_config(config)


class DeployTarget(str, Enum):
    k8s = "k8s"
    ec2 = "ec2"
    local = "local"


@app.command()
def deploy(
    target: DeployTarget = DeployTarget.k8s,
) -> None:
    """Deploy TaskFlow stack to the selected target."""
    cfg = _cfg()
    typer.echo(f"Deploying TaskFlow to {target.value} (env={cfg['environment']})...")
    result = {"target": target.value, "namespace": cfg["namespace"], "status": "deployed"}
    typer.echo(json.dumps(result, indent=2))


@app.command()
def status(
    namespace: Annotated[Optional[str], typer.Option(help="Override K8s namespace")] = None,
) -> None:
    """Show TaskFlow platform status."""
    cfg = _cfg()
    ns = namespace or cfg["namespace"]
    result = {
        "environment": cfg["environment"],
        "namespace": ns,
        "api": cfg.get("api", {}).get("base_url"),
        "healthy": True,
    }
    typer.echo(json.dumps(result, indent=2))


@app.command()
def logs(
    service: Annotated[str, typer.Argument(help="Service name")] = "taskflow-api",
    tail: Annotated[int, typer.Option(help="Number of log lines")] = 50,
) -> None:
    """Tail logs for a TaskFlow service."""
    cfg = _cfg()
    typer.echo(f"[{cfg['environment']}] Last {tail} lines from {service}:")
    typer.echo(f"  INFO  {service} ready — namespace={cfg['namespace']}")


@app.command("config")
def show_config(
    show: Annotated[bool, typer.Option("--show", help="Print resolved configuration")] = False,
) -> None:
    """Display or validate TaskFlow CLI configuration."""
    cfg = _cfg()
    if show:
        typer.echo(json.dumps(cfg, indent=2))
    else:
        typer.echo(f"Config loaded — env={cfg['environment']} ns={cfg['namespace']}")


if __name__ == "__main__":
    app()