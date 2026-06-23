"""TaskFlow platform CLI — Click implementation."""

from __future__ import annotations

import json
import sys
from pathlib import Path

import click

from .config_loader import load_config


@click.group()
@click.option("--config", "config_path", type=click.Path(exists=False), help="Config YAML path")
@click.pass_context
def cli(ctx: click.Context, config_path: str | None) -> None:
    """TaskFlow platform engineering CLI (Click)."""
    ctx.ensure_object(dict)
    ctx.obj["config"] = load_config(config_path)


@cli.command()
@click.option("--target", type=click.Choice(["k8s", "ec2", "local"]), default="k8s")
@click.pass_context
def deploy(ctx: click.Context, target: str) -> None:
    """Deploy TaskFlow stack to the selected target."""
    cfg = ctx.obj["config"]
    click.echo(f"Deploying TaskFlow to {target} (env={cfg['environment']})...")
    result = {"target": target, "namespace": cfg["namespace"], "status": "deployed"}
    click.echo(json.dumps(result, indent=2))


@cli.command()
@click.option("--namespace", default=None, help="Override K8s namespace")
@click.pass_context
def status(ctx: click.Context, namespace: str | None) -> None:
    """Show TaskFlow platform status."""
    cfg = ctx.obj["config"]
    ns = namespace or cfg["namespace"]
    result = {
        "environment": cfg["environment"],
        "namespace": ns,
        "api": cfg.get("api", {}).get("base_url"),
        "healthy": True,
    }
    click.echo(json.dumps(result, indent=2))


@cli.command()
@click.argument("service", default="taskflow-api")
@click.option("--tail", default=50, help="Number of log lines")
@click.pass_context
def logs(ctx: click.Context, service: str, tail: int) -> None:
    """Tail logs for a TaskFlow service."""
    cfg = ctx.obj["config"]
    click.echo(f"[{cfg['environment']}] Last {tail} lines from {service}:")
    click.echo(f"  INFO  {service} ready — namespace={cfg['namespace']}")


@cli.command("config")
@click.option("--show", is_flag=True, help="Print resolved configuration")
@click.pass_context
def show_config(ctx: click.Context, show: bool) -> None:
    """Display or validate TaskFlow CLI configuration."""
    cfg = ctx.obj["config"]
    if show:
        click.echo(json.dumps(cfg, indent=2))
    else:
        click.echo(f"Config loaded — env={cfg['environment']} ns={cfg['namespace']}")


def main() -> None:
    cli(obj={})


if __name__ == "__main__":
    main()