"""TaskFlow FastAPI backend — Week 7 Docker labs."""

from __future__ import annotations

import os
from datetime import datetime, timezone

from fastapi import FastAPI
from pydantic import BaseModel, Field

app = FastAPI(title="TaskFlow API", version="0.7.0")

TASKS = [
    {"id": 1, "title": "Containerize frontend", "status": "in_progress", "owner": "platform-team"},
    {"id": 2, "title": "Containerize backend", "status": "todo", "owner": "platform-team"},
    {"id": 3, "title": "Compose full stack", "status": "todo", "owner": "platform-team"},
]


class TaskCreate(BaseModel):
    title: str = Field(min_length=1, max_length=200)
    status: str = Field(default="todo", pattern=r"^(todo|in_progress|done)$")
    owner: str = Field(default="platform-team")


@app.get("/health")
def health():
    return {
        "status": "healthy",
        "service": "taskflow-api",
        "version": os.getenv("TASKFLOW_VERSION", "week7"),
        "environment": os.getenv("APP_ENV", "dev"),
        "timestamp": datetime.now(timezone.utc).isoformat(),
    }


@app.get("/")
def index():
    return {"message": "TaskFlow API", "endpoints": ["/health", "/api/tasks"]}


@app.get("/api/tasks")
def list_tasks():
    return {"tasks": TASKS, "count": len(TASKS)}


@app.post("/api/tasks", status_code=201)
def create_task(body: TaskCreate):
    task = {"id": len(TASKS) + 1, **body.model_dump()}
    TASKS.append(task)
    return task