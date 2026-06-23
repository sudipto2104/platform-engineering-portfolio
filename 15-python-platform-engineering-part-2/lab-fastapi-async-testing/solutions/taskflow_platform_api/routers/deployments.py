"""Async deployment endpoints with background tasks."""

from __future__ import annotations

import uuid
from typing import Annotated

import httpx
from fastapi import APIRouter, BackgroundTasks, HTTPException
from pydantic import BaseModel, Field

from ..tasks.background import get_job_status, run_deployment_job

router = APIRouter(prefix="/api/v1/deployments", tags=["deployments"])


class DeploymentRequest(BaseModel):
    service_name: str = Field(min_length=1, max_length=100)
    environment: str = Field(default="dev", pattern=r"^(dev|staging|production)$")


class DeploymentResponse(BaseModel):
    job_id: str
    status: str
    message: str


@router.post("", response_model=DeploymentResponse, status_code=202)
async def trigger_deployment(
    body: DeploymentRequest,
    background_tasks: BackgroundTasks,
):
    """Queue a background deployment job."""
    job_id = uuid.uuid4().hex[:12]
    background_tasks.add_task(
        run_deployment_job, job_id, body.service_name, body.environment
    )
    return DeploymentResponse(
        job_id=job_id,
        status="queued",
        message=f"Deployment of {body.service_name} queued",
    )


@router.get("/{job_id}")
async def get_deployment_status(job_id: str):
    job = get_job_status(job_id)
    if not job:
        raise HTTPException(status_code=404, detail="Job not found")
    return job


@router.get("/health/external")
async def check_external_health(url: str = "http://localhost:8080/health"):
    """Async health check against TaskFlow API (Week 7 stack)."""
    try:
        async with httpx.AsyncClient(timeout=5.0) as client:
            resp = await client.get(url)
            return {"url": url, "status_code": resp.status_code, "healthy": resp.is_success}
    except httpx.HTTPError as exc:
        return {"url": url, "healthy": False, "error": str(exc)}