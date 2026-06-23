"""RBAC-protected platform resource endpoints."""

from __future__ import annotations

from typing import Annotated, List

from fastapi import APIRouter, Depends

from ..auth.dependencies import TokenUser, require_permission
from ..auth.rbac import Permission
from ..schemas import ServiceCreate, ServiceResponse

router = APIRouter(prefix="/api/v1", tags=["platform-resources"])

_SERVICES: list[dict] = [
    {"id": 1, "name": "taskflow-api", "environment": "dev", "owner": "platform-team"},
]
_next_id = 2


@router.get("/services", response_model=List[ServiceResponse])
def list_services(
    _: Annotated[TokenUser, Depends(require_permission(Permission.READ))],
):
    return _SERVICES


@router.post("/services", response_model=ServiceResponse, status_code=201)
def create_service(
    body: ServiceCreate,
    _: Annotated[TokenUser, Depends(require_permission(Permission.WRITE))],
):
    global _next_id
    service = {"id": _next_id, **body.model_dump()}
    _next_id += 1
    _SERVICES.append(service)
    return service


@router.delete("/services/{service_id}", status_code=204)
def delete_service(
    service_id: int,
    _: Annotated[TokenUser, Depends(require_permission(Permission.DELETE))],
):
    global _SERVICES
    _SERVICES = [s for s in _SERVICES if s["id"] != service_id]