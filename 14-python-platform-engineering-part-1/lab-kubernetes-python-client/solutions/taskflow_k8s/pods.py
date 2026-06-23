"""Pod operations for TaskFlow namespace."""

from __future__ import annotations

from typing import Any

from kubernetes.client.exceptions import ApiException

from .client_factory import get_api_clients


def list_taskflow_pods(namespace: str = "taskflow", label_selector: str = "") -> list[dict[str, Any]]:
    core, _ = get_api_clients()
    selector = label_selector or "app.kubernetes.io/part-of=taskflow"
    try:
        resp = core.list_namespaced_pod(namespace=namespace, label_selector=selector)
    except ApiException as exc:
        raise RuntimeError(f"List pods failed: {exc.reason}") from exc

    return [
        {
            "name": pod.metadata.name,
            "phase": pod.status.phase,
            "node": pod.spec.node_name,
            "ready": sum(1 for c in (pod.status.container_statuses or []) if c.ready),
            "restarts": sum(c.restart_count for c in (pod.status.container_statuses or [])),
        }
        for pod in resp.items
    ]


def wait_for_pod_ready(
    pod_name: str,
    namespace: str = "taskflow",
    timeout_seconds: int = 120,
) -> bool:
    core, _ = get_api_clients()
    import time

    deadline = time.time() + timeout_seconds
    while time.time() < deadline:
        try:
            pod = core.read_namespaced_pod(name=pod_name, namespace=namespace)
        except ApiException as exc:
            raise RuntimeError(f"Read pod failed: {exc.reason}") from exc
        statuses = pod.status.container_statuses or []
        if statuses and all(s.ready for s in statuses):
            return True
        time.sleep(2)
    return False


def delete_taskflow_pod(pod_name: str, namespace: str = "taskflow") -> dict[str, str]:
    core, _ = get_api_clients()
    try:
        core.delete_namespaced_pod(name=pod_name, namespace=namespace)
    except ApiException as exc:
        raise RuntimeError(f"Delete pod failed: {exc.reason}") from exc
    return {"deleted": pod_name, "namespace": namespace}