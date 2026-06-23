"""CloudWatch metrics and alarms for TaskFlow platform health."""

from __future__ import annotations

from datetime import datetime, timezone
from typing import Any

import boto3
from botocore.exceptions import ClientError

from .config import CONFIG


def get_cloudwatch_client():
    return boto3.client("cloudwatch", region_name=CONFIG.region)


def publish_taskflow_health_metric(
    healthy: bool,
    task_count: int,
    environment: str = "dev",
) -> dict[str, Any]:
    """Publish custom TaskFlow metrics to CloudWatch."""
    client = get_cloudwatch_client()
    timestamp = datetime.now(timezone.utc)
    try:
        client.put_metric_data(
            Namespace=CONFIG.cloudwatch_namespace,
            MetricData=[
                {
                    "MetricName": "TaskFlowHealth",
                    "Value": 1.0 if healthy else 0.0,
                    "Unit": "None",
                    "Timestamp": timestamp,
                    "Dimensions": [
                        {"Name": "Environment", "Value": environment},
                        {"Name": "Service", "Value": "taskflow-api"},
                    ],
                },
                {
                    "MetricName": "TaskCount",
                    "Value": float(task_count),
                    "Unit": "Count",
                    "Timestamp": timestamp,
                    "Dimensions": [
                        {"Name": "Environment", "Value": environment},
                    ],
                },
            ],
        )
    except ClientError as exc:
        raise RuntimeError(f"CloudWatch put_metric_data failed: {exc}") from exc
    return {"namespace": CONFIG.cloudwatch_namespace, "published_at": timestamp.isoformat()}


def create_taskflow_health_alarm(
    alarm_name: str = "taskflow-api-unhealthy",
    threshold: float = 1.0,
    environment: str = "dev",
) -> dict[str, Any]:
    client = get_cloudwatch_client()
    try:
        client.put_metric_alarm(
            AlarmName=alarm_name,
            AlarmDescription="TaskFlow API health dropped below threshold",
            MetricName="TaskFlowHealth",
            Namespace=CONFIG.cloudwatch_namespace,
            Statistic="Average",
            Period=300,
            EvaluationPeriods=2,
            Threshold=threshold,
            ComparisonOperator="LessThanThreshold",
            Dimensions=[{"Name": "Environment", "Value": environment}],
            TreatMissingData="breaching",
        )
    except ClientError as exc:
        raise RuntimeError(f"CloudWatch alarm failed: {exc}") from exc
    return {"alarm_name": alarm_name, "threshold": threshold}