"""{{ serviceName }} — FastAPI microservice scaffolded via Backstage."""

from __future__ import annotations

import os
from datetime import datetime, timezone

from fastapi import FastAPI
from pydantic import BaseModel, Field

app = FastAPI(
    title="{{ serviceName }}",
    description="{{ description }}",
    version="0.1.0",
)


class HealthResponse(BaseModel):
    status: str
    service: str
    environment: str
    timestamp: str


@app.get("/health", response_model=HealthResponse)
def health() -> HealthResponse:
    return HealthResponse(
        status="healthy",
        service="{{ serviceName }}",
        environment=os.getenv("APP_ENV", "{{ environment }}"),
        timestamp=datetime.now(timezone.utc).isoformat(),
    )


@app.get("/")
def root():
    return {"service": "{{ serviceName }}", "owner": "{{ owner }}"}


class ItemCreate(BaseModel):
    name: str = Field(min_length=1, max_length=200)


ITEMS: list[dict] = []


@app.get("/api/items")
def list_items():
    return {"items": ITEMS, "count": len(ITEMS)}


@app.post("/api/items", status_code=201)
def create_item(body: ItemCreate):
    item = {"id": len(ITEMS) + 1, **body.model_dump()}
    ITEMS.append(item)
    return item