"""TaskFlow FastAPI — Week 8 K8s (startup logging for DNS discovery lab)."""

from __future__ import annotations

import logging
import os
from datetime import datetime, timezone

from fastapi import FastAPI
from pydantic import BaseModel, Field

logging.basicConfig(level=logging.INFO)
log = logging.getLogger("taskflow")

app = FastAPI(title="TaskFlow API", version="0.8.0")

TASKS = [
    {"id": 1, "title": "Deploy to Kubernetes", "status": "in_progress", "owner": "platform-team"},
    {"id": 2, "title": "Configure ConfigMaps", "status": "todo", "owner": "platform-team"},
]


class TaskCreate(BaseModel):
    title: str = Field(min_length=1, max_length=200)
    status: str = Field(default="todo", pattern=r"^(todo|in_progress|done)$")
    owner: str = Field(default="platform-team")


@app.on_event("startup")
async def log_connections():
    db = os.getenv("DATABASE_URL", "not-set")
    redis = os.getenv("REDIS_URL", "not-set")
    log.info("K8s DNS targets — DATABASE_URL=%s REDIS_URL=%s", db, redis)


@app.get("/health")
def health():
    return {
        "status": "healthy",
        "service": "taskflow-api",
        "version": os.getenv("TASKFLOW_VERSION", "week8"),
        "environment": os.getenv("APP_ENV", "dev"),
        "timestamp": datetime.now(timezone.utc).isoformat(),
    }


@app.get("/api/tasks")
def list_tasks():
    return {"tasks": TASKS, "count": len(TASKS)}