"""Pydantic schemas."""

from __future__ import annotations

from pydantic import BaseModel, Field


class ServiceBase(BaseModel):
    name: str = Field(min_length=1, max_length=100)
    environment: str = Field(default="dev", pattern=r"^(dev|staging|production)$")
    owner: str = "platform-team"


class ServiceCreate(ServiceBase):
    pass


class ServiceResponse(ServiceBase):
    id: int