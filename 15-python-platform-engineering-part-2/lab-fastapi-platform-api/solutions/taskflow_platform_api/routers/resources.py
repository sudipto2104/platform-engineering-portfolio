"""CRUD endpoints for TaskFlow platform resources."""

from __future__ import annotations

from typing import List

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from ..database import get_db
from ..models import PlatformEnvironment, PlatformService
from ..schemas import (
    EnvironmentCreate,
    EnvironmentResponse,
    ServiceCreate,
    ServiceResponse,
    ServiceUpdate,
)

router = APIRouter(prefix="/api/v1", tags=["platform-resources"])


@router.get("/services", response_model=List[ServiceResponse])
def list_services(db: Session = Depends(get_db)):
    return db.query(PlatformService).order_by(PlatformService.id).all()


@router.post("/services", response_model=ServiceResponse, status_code=status.HTTP_201_CREATED)
def create_service(body: ServiceCreate, db: Session = Depends(get_db)):
    if db.query(PlatformService).filter(PlatformService.name == body.name).first():
        raise HTTPException(status_code=409, detail="Service name already exists")
    service = PlatformService(**body.model_dump())
    db.add(service)
    db.commit()
    db.refresh(service)
    return service


@router.get("/services/{service_id}", response_model=ServiceResponse)
def get_service(service_id: int, db: Session = Depends(get_db)):
    service = db.get(PlatformService, service_id)
    if not service:
        raise HTTPException(status_code=404, detail="Service not found")
    return service


@router.put("/services/{service_id}", response_model=ServiceResponse)
def update_service(service_id: int, body: ServiceUpdate, db: Session = Depends(get_db)):
    service = db.get(PlatformService, service_id)
    if not service:
        raise HTTPException(status_code=404, detail="Service not found")
    for key, value in body.model_dump(exclude_unset=True).items():
        setattr(service, key, value)
    db.commit()
    db.refresh(service)
    return service


@router.delete("/services/{service_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_service(service_id: int, db: Session = Depends(get_db)):
    service = db.get(PlatformService, service_id)
    if not service:
        raise HTTPException(status_code=404, detail="Service not found")
    db.delete(service)
    db.commit()


@router.get("/environments", response_model=List[EnvironmentResponse])
def list_environments(db: Session = Depends(get_db)):
    return db.query(PlatformEnvironment).order_by(PlatformEnvironment.id).all()


@router.post(
    "/environments",
    response_model=EnvironmentResponse,
    status_code=status.HTTP_201_CREATED,
)
def create_environment(body: EnvironmentCreate, db: Session = Depends(get_db)):
    if db.query(PlatformEnvironment).filter(PlatformEnvironment.name == body.name).first():
        raise HTTPException(status_code=409, detail="Environment already exists")
    env = PlatformEnvironment(**body.model_dump())
    db.add(env)
    db.commit()
    db.refresh(env)
    return env