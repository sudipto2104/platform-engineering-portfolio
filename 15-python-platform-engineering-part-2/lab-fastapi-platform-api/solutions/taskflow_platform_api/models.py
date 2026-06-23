"""SQLAlchemy ORM models for TaskFlow platform resources."""

from __future__ import annotations

from datetime import datetime, timezone

from sqlalchemy import DateTime, String, Text
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column


class Base(DeclarativeBase):
    pass


class PlatformService(Base):
    __tablename__ = "platform_services"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    name: Mapped[str] = mapped_column(String(100), unique=True, index=True)
    description: Mapped[str] = mapped_column(Text, default="")
    environment: Mapped[str] = mapped_column(String(50), default="dev")
    status: Mapped[str] = mapped_column(String(30), default="active")
    owner: Mapped[str] = mapped_column(String(100), default="platform-team")
    created_at: Mapped[datetime] = mapped_column(
        DateTime, default=lambda: datetime.now(timezone.utc)
    )


class PlatformEnvironment(Base):
    __tablename__ = "platform_environments"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    name: Mapped[str] = mapped_column(String(50), unique=True, index=True)
    region: Mapped[str] = mapped_column(String(50), default="us-east-1")
    cluster: Mapped[str] = mapped_column(String(100), default="taskflow-local")
    created_at: Mapped[datetime] = mapped_column(
        DateTime, default=lambda: datetime.now(timezone.utc)
    )