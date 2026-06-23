"""Service operations for TaskFlow networking."""

from __future__ import annotations

from typing import Any

from kubernetes.client.exceptions import ApiException

from .client_factory import get_api_clients


def list_taskflow_services(namespace: str = "taskflow") -> list[dict[str, Any]]:
    core, _ = get_api_clients()
    try:
        resp = core.list_namespaced_service(namespace=namespace)
    except ApiException as exc:
        raise RuntimeError(f"List services failed: {exc.reason}") from exc

    services: list[dict[str, Any]] = []
    for svc in resp.items:
        ports = [
            {"port": p.port, "target_port": p.target_port, "protocol": p.protocol}
            for p in (svc.spec.ports or [])
        ]
        services.append(
            {
                "name": svc.metadata.name,
                "type": svc.spec.type,
                "cluster_ip": svc.spec.cluster_ip,
                "ports": ports,
            }
        )
    return services


def get_service_endpoints(service_name: str, namespace: str = "taskflow") -> list[str]:
    core, _ = get_api_clients()
    try:
        ep = core.read_namespaced_endpoints(name=service_name, namespace=namespace)
    except ApiException as exc:
        raise RuntimeError(f"Read endpoints failed: {exc.reason}") from exc

    addresses: list[str] = []
    for subset in ep.subsets or []:
        for addr in subset.addresses or []:
            addresses.append(addr.ip)
    return addresses