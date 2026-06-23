"""TaskFlow Platform API — async operations and background tasks."""

from __future__ import annotations

from fastapi import FastAPI

from .routers import deployments, health

app = FastAPI(
    title="TaskFlow Platform API (Async)",
    description="Async deployment workflows with background tasks",
    version="0.15.2",
)

app.include_router(health.router)
app.include_router(deployments.router)