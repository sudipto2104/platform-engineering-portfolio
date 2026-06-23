"""EC2 automation for TaskFlow application servers."""

from __future__ import annotations

from typing import Any

import boto3
from botocore.exceptions import ClientError

from .config import CONFIG


def get_ec2_client():
    return boto3.client("ec2", region_name=CONFIG.region)


def get_ec2_resource():
    return boto3.resource("ec2", region_name=CONFIG.region)


def _taskflow_filter() -> list[dict[str, Any]]:
    return [{"Name": "tag:Project", "Values": [CONFIG.project_tag]}]


def describe_taskflow_instances() -> list[dict[str, Any]]:
    """List EC2 instances tagged Project=TaskFlow."""
    client = get_ec2_client()
    try:
        resp = client.describe_instances(Filters=_taskflow_filter())
    except ClientError as exc:
        raise RuntimeError(f"EC2 describe failed: {exc}") from exc

    instances: list[dict[str, Any]] = []
    for reservation in resp.get("Reservations", []):
        for inst in reservation.get("Instances", []):
            tags = {t["Key"]: t["Value"] for t in inst.get("Tags", [])}
            instances.append(
                {
                    "instance_id": inst["InstanceId"],
                    "state": inst["State"]["Name"],
                    "instance_type": inst.get("InstanceType"),
                    "private_ip": inst.get("PrivateIpAddress"),
                    "name": tags.get("Name", "unknown"),
                    "environment": tags.get("Environment", "dev"),
                }
            )
    return instances


def start_taskflow_instances(instance_ids: list[str] | None = None) -> dict[str, Any]:
    client = get_ec2_client()
    ids = instance_ids or [i["instance_id"] for i in describe_taskflow_instances()]
    if not ids:
        return {"starting": [], "message": "No TaskFlow instances found"}
    try:
        return client.start_instances(InstanceIds=ids)
    except ClientError as exc:
        raise RuntimeError(f"EC2 start failed: {exc}") from exc


def stop_taskflow_instances(instance_ids: list[str], dry_run: bool = False) -> dict[str, Any]:
    client = get_ec2_client()
    try:
        return client.stop_instances(InstanceIds=instance_ids, DryRun=dry_run)
    except ClientError as exc:
        if exc.response["Error"].get("Code") == "DryRunOperation":
            return {"dry_run": True, "instance_ids": instance_ids}
        raise RuntimeError(f"EC2 stop failed: {exc}") from exc