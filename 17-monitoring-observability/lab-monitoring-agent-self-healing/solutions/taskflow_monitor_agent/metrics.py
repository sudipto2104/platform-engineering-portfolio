"""Prometheus-compatible metrics for the TaskFlow monitoring agent."""

from __future__ import annotations

import time
from typing import Any

import requests
from prometheus_client import Counter, Gauge, start_http_server

API_URL = "http://taskflow-api:8080"

AGENT_CHECKS = Counter(
    "taskflow_agent_checks_total",
    "Total health checks performed by the monitoring agent",
    ["target", "result"],
)
AGENT_REMEDIATIONS = Counter(
    "taskflow_agent_remediations_total",
    "Total automated remediation actions executed",
    ["action", "result"],
)
TARGET_HEALTHY = Gauge(
    "taskflow_agent_target_healthy",
    "1 if monitored target is healthy",
    ["target"],
)
CHECK_LATENCY = Gauge(
    "taskflow_agent_check_latency_seconds",
    "Last health check latency",
    ["target"],
)


def check_api_health(url: str = f"{API_URL}/health") -> dict[str, Any]:
    start = time.perf_counter()
    try:
        resp = requests.get(url, timeout=5)
        latency = time.perf_counter() - start
        healthy = resp.ok and resp.json().get("status") == "healthy"
        TARGET_HEALTHY.labels("taskflow-api").set(1 if healthy else 0)
        CHECK_LATENCY.labels("taskflow-api").set(latency)
        AGENT_CHECKS.labels("taskflow-api", "pass" if healthy else "fail").inc()
        return {"healthy": healthy, "latency": latency, "status_code": resp.status_code}
    except requests.RequestException as exc:
        TARGET_HEALTHY.labels("taskflow-api").set(0)
        AGENT_CHECKS.labels("taskflow-api", "error").inc()
        return {"healthy": False, "error": str(exc)}


def start_metrics_server(port: int = 9101) -> None:
    start_http_server(port)