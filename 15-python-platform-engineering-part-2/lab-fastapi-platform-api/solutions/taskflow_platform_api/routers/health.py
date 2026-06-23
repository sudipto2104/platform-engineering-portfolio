"""Health and metadata endpoints."""

from __future__ import annotations

import os
from datetime import datetime, timezone

from fastapi import APIRouter

router = APIRouter(tags=["health"])


@router.get("/health")
def health_check():
    return {
        "status": "healthy",
        "service": "taskflow-platform-api",
        "version": os.getenv("TASKFLOW_API_VERSION", "0.15.0"),
        "timestamp": datetime.now(timezone.utc).isoformat(),
    }


@router.get("/")
def root():
    return {
        "message": "TaskFlow Platform API",
        "docs": "/docs",
        "openapi": "/openapi.json",
    }