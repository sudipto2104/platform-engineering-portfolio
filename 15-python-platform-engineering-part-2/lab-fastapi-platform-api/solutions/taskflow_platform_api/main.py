"""TaskFlow Platform API — FastAPI infrastructure management."""

from __future__ import annotations

from fastapi import FastAPI

from .database import engine
from .models import Base
from .routers import health, resources

app = FastAPI(
    title="TaskFlow Platform API",
    description="RESTful API for TaskFlow platform engineering infrastructure management",
    version="0.15.0",
    docs_url="/docs",
    redoc_url="/redoc",
    openapi_url="/openapi.json",
)

Base.metadata.create_all(bind=engine)

app.include_router(health.router)
app.include_router(resources.router)