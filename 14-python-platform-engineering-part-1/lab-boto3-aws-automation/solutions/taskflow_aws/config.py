"""TaskFlow AWS configuration — environment-driven, no hardcoded credentials."""

from __future__ import annotations

import os
from dataclasses import dataclass


@dataclass(frozen=True)
class TaskFlowAWSConfig:
    region: str = os.getenv("AWS_REGION", "us-east-1")
    project_tag: str = "TaskFlow"
    s3_bucket: str = os.getenv("TASKFLOW_S3_BUCKET", "taskflow-attachments-dev")
    cloudwatch_namespace: str = os.getenv("TASKFLOW_CW_NAMESPACE", "TaskFlow/Platform")
    lambda_health_function: str = os.getenv(
        "TASKFLOW_LAMBDA_HEALTH", "taskflow-health-check"
    )


CONFIG = TaskFlowAWSConfig()