"""Background task workers for platform deployments."""

from __future__ import annotations

import asyncio
from datetime import datetime, timezone
from typing import Any

# In-memory job store for lab demonstration
JOBS: dict[str, dict[str, Any]] = {}


async def run_deployment_job(job_id: str, service_name: str, environment: str) -> None:
    """Simulate an async deployment rollout with status updates."""
    JOBS[job_id] = {
        "job_id": job_id,
        "service": service_name,
        "environment": environment,
        "status": "running",
        "started_at": datetime.now(timezone.utc).isoformat(),
    }
    await asyncio.sleep(0.1)  # simulate work
    JOBS[job_id]["status"] = "deploying"
    await asyncio.sleep(0.1)
    JOBS[job_id].update(
        {
            "status": "completed",
            "completed_at": datetime.now(timezone.utc).isoformat(),
            "message": f"{service_name} deployed to {environment}",
        }
    )


def get_job_status(job_id: str) -> dict[str, Any] | None:
    return JOBS.get(job_id)