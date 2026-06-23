"""Lambda automation for TaskFlow health-check workflows."""

from __future__ import annotations

import json
from typing import Any

import boto3
from botocore.exceptions import ClientError

from .config import CONFIG


def get_lambda_client():
    return boto3.client("lambda", region_name=CONFIG.region)


def list_taskflow_functions(prefix: str = "taskflow") -> list[dict[str, Any]]:
    client = get_lambda_client()
    functions: list[dict[str, Any]] = []
    try:
        paginator = client.get_paginator("list_functions")
        for page in paginator.paginate():
            for fn in page.get("Functions", []):
                if fn["FunctionName"].startswith(prefix):
                    functions.append(
                        {
                            "name": fn["FunctionName"],
                            "runtime": fn.get("Runtime"),
                            "last_modified": fn.get("LastModified"),
                        }
                    )
    except ClientError as exc:
        raise RuntimeError(f"Lambda list failed: {exc}") from exc
    return functions


def invoke_health_check(
    payload: dict[str, Any] | None = None,
    invocation_type: str = "RequestResponse",
) -> dict[str, Any]:
    """Invoke the TaskFlow health-check Lambda function."""
    client = get_lambda_client()
    body = payload or {"action": "health_check", "service": "taskflow-api"}
    try:
        resp = client.invoke(
            FunctionName=CONFIG.lambda_health_function,
            InvocationType=invocation_type,
            Payload=json.dumps(body).encode(),
        )
    except ClientError as exc:
        raise RuntimeError(f"Lambda invoke failed: {exc}") from exc

    result: dict[str, Any] = {
        "status_code": resp.get("StatusCode"),
        "function_error": resp.get("FunctionError"),
    }
    if resp.get("Payload"):
        result["payload"] = json.loads(resp["Payload"].read().decode())
    return result