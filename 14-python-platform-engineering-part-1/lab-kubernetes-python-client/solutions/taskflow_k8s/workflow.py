"""End-to-end TaskFlow Kubernetes workflow automation."""

from __future__ import annotations

from pathlib import Path
from typing import Any

from .deployments import apply_manifest, get_deployment_status, scale_deployment
from .pods import list_taskflow_pods
from .services import list_taskflow_services


MANIFEST_DIR = Path(__file__).resolve().parent.parent / "manifests"


def deploy_taskflow_stack(namespace: str = "taskflow") -> dict[str, Any]:
    """Apply namespace, deployment, and service manifests in order."""
    order = ["namespace.yaml", "deployment.yaml", "service.yaml"]
    applied: list[dict[str, str]] = []
    for filename in order:
        path = MANIFEST_DIR / filename
        if path.exists():
            applied.append(apply_manifest(path, namespace=namespace))
    return {"namespace": namespace, "applied": applied}


def get_taskflow_stack_status(namespace: str = "taskflow") -> dict[str, Any]:
    """Collect pods, deployments, and services for TaskFlow."""
    deployments = []
    for name in ("taskflow-api", "taskflow-frontend"):
        try:
            deployments.append(get_deployment_status(name, namespace))
        except RuntimeError:
            pass

    return {
        "namespace": namespace,
        "pods": list_taskflow_pods(namespace),
        "deployments": deployments,
        "services": list_taskflow_services(namespace),
    }


def scale_taskflow_api(replicas: int, namespace: str = "taskflow") -> dict[str, Any]:
    return scale_deployment("taskflow-api", replicas, namespace)