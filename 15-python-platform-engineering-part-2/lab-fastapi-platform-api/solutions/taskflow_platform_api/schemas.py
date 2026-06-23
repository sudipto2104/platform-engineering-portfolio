"""Pydantic schemas for request/response validation."""

from __future__ import annotations

from datetime import datetime
from typing import Optional

from pydantic import BaseModel, ConfigDict, Field


class ServiceBase(BaseModel):
    name: str = Field(min_length=1, max_length=100)
    description: str = ""
    environment: str = Field(default="dev", pattern=r"^(dev|staging|production)$")
    status: str = Field(default="active", pattern=r"^(active|inactive|deploying)$")
    owner: str = "platform-team"


class ServiceCreate(ServiceBase):
    pass


class ServiceUpdate(BaseModel):
    description: Optional[str] = None
    environment: Optional[str] = Field(default=None, pattern=r"^(dev|staging|production)$")
    status: Optional[str] = Field(default=None, pattern=r"^(active|inactive|deploying)$")
    owner: Optional[str] = None


class ServiceResponse(ServiceBase):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created_at: datetime


class EnvironmentBase(BaseModel):
    name: str = Field(min_length=1, max_length=50)
    region: str = "us-east-1"
    cluster: str = "taskflow-local"


class EnvironmentCreate(EnvironmentBase):
    pass


class EnvironmentResponse(EnvironmentBase):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created_at: datetime