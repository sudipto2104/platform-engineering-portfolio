"""Automated remediation workflows for TaskFlow incidents."""

from __future__ import annotations

import json
import logging
import subprocess
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

from .metrics import AGENT_REMEDIATIONS

logger = logging.getLogger(__name__)
INCIDENT_LOG = Path("/tmp/taskflow-incidents.jsonl")


def log_incident(alert: dict[str, Any], action: str, result: str) -> None:
    entry = {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "alert": alert["name"],
        "severity": alert["severity"],
        "action": action,
        "result": result,
    }
    INCIDENT_LOG.parent.mkdir(parents=True, exist_ok=True)
    with INCIDENT_LOG.open("a") as fh:
        fh.write(json.dumps(entry) + "\n")
    logger.info("Incident logged: %s", entry)


def restart_pod(namespace: str = "taskflow", deployment: str = "taskflow-api", dry_run: bool = False) -> str:
    """Delete pods to trigger Kubernetes restart."""
    cmd = f"kubectl rollout restart deployment/{deployment} -n {namespace}"
    if dry_run:
        log_incident({"name": "api_down", "severity": "critical"}, "restart_pod", "dry-run")
        AGENT_REMEDIATIONS.labels("restart_pod", "dry-run").inc()
        return f"[dry-run] {cmd}"
    try:
        subprocess.run(cmd.split(), check=True, capture_output=True, text=True)
        AGENT_REMEDIATIONS.labels("restart_pod", "success").inc()
        log_incident({"name": "api_down", "severity": "critical"}, "restart_pod", "success")
        return "restart triggered"
    except subprocess.CalledProcessError as exc:
        AGENT_REMEDIATIONS.labels("restart_pod", "failure").inc()
        log_incident({"name": "api_down", "severity": "critical"}, "restart_pod", "failure")
        return f"restart failed: {exc.stderr}"


def scale_up(namespace: str = "taskflow", deployment: str = "taskflow-api", replicas: int = 3, dry_run: bool = False) -> str:
    """Scale deployment to handle load."""
    cmd = f"kubectl scale deployment/{deployment} -n {namespace} --replicas={replicas}"
    if dry_run:
        AGENT_REMEDIATIONS.labels("scale_up", "dry-run").inc()
        return f"[dry-run] {cmd}"
    try:
        subprocess.run(cmd.split(), check=True, capture_output=True, text=True)
        AGENT_REMEDIATIONS.labels("scale_up", "success").inc()
        log_incident({"name": "high_latency", "severity": "warning"}, "scale_up", "success")
        return f"scaled to {replicas}"
    except subprocess.CalledProcessError as exc:
        AGENT_REMEDIATIONS.labels("scale_up", "failure").inc()
        return f"scale failed: {exc.stderr}"


REMEDIATION_HANDLERS = {
    "restart_pod": restart_pod,
    "restart_deployment": restart_pod,
    "scale_up": scale_up,
}


def execute_remediation(alert: dict[str, Any], dry_run: bool = False) -> str:
    handler = REMEDIATION_HANDLERS.get(alert.get("remediation", ""))
    if not handler:
        return f"no handler for {alert.get('remediation')}"
    return handler(dry_run=dry_run)