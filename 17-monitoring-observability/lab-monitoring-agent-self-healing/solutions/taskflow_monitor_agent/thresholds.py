"""Threshold-based alert evaluation for TaskFlow."""

from __future__ import annotations

from dataclasses import dataclass
from typing import Any


@dataclass
class Threshold:
    name: str
    metric: str
    operator: str  # gt, lt, eq
    value: float
    severity: str
    remediation: str


DEFAULT_THRESHOLDS = [
    Threshold("api_down", "healthy", "eq", 0.0, "critical", "restart_pod"),
    Threshold("high_latency", "latency", "gt", 1.0, "warning", "scale_up"),
    Threshold("error_streak", "consecutive_failures", "gt", 3.0, "critical", "restart_deployment"),
]


def evaluate_thresholds(metrics: dict[str, Any], thresholds: list[Threshold] | None = None) -> list[dict]:
    """Evaluate metrics against thresholds and return triggered alerts."""
    rules = thresholds or DEFAULT_THRESHOLDS
    triggered: list[dict] = []

    for rule in rules:
        actual = metrics.get(rule.metric)
        if actual is None:
            continue
        fired = _compare(actual, rule.operator, rule.value)
        if fired:
            triggered.append(
                {
                    "name": rule.name,
                    "severity": rule.severity,
                    "remediation": rule.remediation,
                    "actual": actual,
                    "threshold": rule.value,
                }
            )
    return triggered


def _compare(actual: float, operator: str, threshold: float) -> bool:
    if operator == "gt":
        return actual > threshold
    if operator == "lt":
        return actual < threshold
    if operator == "eq":
        return actual == threshold
    return False