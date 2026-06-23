"""Deployment operations for TaskFlow workloads."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import yaml
from kubernetes import client
from kubernetes.client.exceptions import ApiException

from .client_factory import get_api_clients


def get_deployment_status(name: str, namespace: str = "taskflow") -> dict[str, Any]:
    _, apps = get_api_clients()
    try:
        dep = apps.read_namespaced_deployment(name=name, namespace=namespace)
    except ApiException as exc:
        raise RuntimeError(f"Read deployment failed: {exc.reason}") from exc

    status = dep.status
    return {
        "name": name,
        "namespace": namespace,
        "replicas": dep.spec.replicas,
        "ready": status.ready_replicas or 0,
        "available": status.available_replicas or 0,
        "updated": status.updated_replicas or 0,
    }


def scale_deployment(name: str, replicas: int, namespace: str = "taskflow") -> dict[str, Any]:
    _, apps = get_api_clients()
    try:
        body = client.V1Scale(
            spec=client.V1ScaleSpec(replicas=replicas),
        )
        apps.patch_namespaced_deployment_scale(
            name=name, namespace=namespace, body=body
        )
    except ApiException as exc:
        raise RuntimeError(f"Scale deployment failed: {exc.reason}") from exc
    return {"name": name, "replicas": replicas, "namespace": namespace}


def apply_manifest(manifest_path: str | Path, namespace: str = "taskflow") -> dict[str, str]:
    """Apply a single YAML manifest via the Kubernetes API."""
    path = Path(manifest_path)
    doc = yaml.safe_load(path.read_text())
    kind = doc["kind"]
    name = doc["metadata"]["name"]
    core, apps = get_api_clients()

    try:
        if kind == "Namespace":
            core.create_namespace(body=client.V1Namespace(**_strip_api_version(doc)))
        elif kind == "Deployment":
            apps.create_namespaced_deployment(
                namespace=namespace,
                body=client.V1Deployment(**_strip_api_version(doc)),
            )
        elif kind == "Service":
            core.create_namespaced_service(
                namespace=namespace,
                body=client.V1Service(**_strip_api_version(doc)),
            )
        else:
            raise ValueError(f"Unsupported kind: {kind}")
    except ApiException as exc:
        if exc.status != 409:
            raise RuntimeError(f"Apply {kind}/{name} failed: {exc.reason}") from exc
    return {"kind": kind, "name": name, "namespace": namespace}


def _strip_api_version(doc: dict) -> dict:
    return {k: v for k, v in doc.items() if k not in ("apiVersion", "kind")}