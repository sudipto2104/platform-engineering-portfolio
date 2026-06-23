"""TaskFlow Platform API with JWT authentication and RBAC."""

from __future__ import annotations

from fastapi import FastAPI

from .routers import auth, resources

app = FastAPI(
    title="TaskFlow Platform API (Auth)",
    description="JWT-authenticated platform API with role-based access control",
    version="0.15.1",
    docs_url="/docs",
)

app.include_router(auth.router)
app.include_router(resources.router)