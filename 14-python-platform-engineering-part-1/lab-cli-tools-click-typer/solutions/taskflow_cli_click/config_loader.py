"""Load TaskFlow CLI configuration from YAML + environment."""

from __future__ import annotations

import os
from pathlib import Path
from typing import Any

import yaml


DEFAULT_CONFIG_PATH = Path(__file__).resolve().parent.parent / "config" / "taskflow.yaml"


def load_config(config_path: str | Path | None = None) -> dict[str, Any]:
    path = Path(config_path or os.getenv("TASKFLOW_CONFIG", DEFAULT_CONFIG_PATH))
    if not path.exists():
        path = path.with_suffix(".yaml.example")
    with path.open() as fh:
        cfg = yaml.safe_load(fh) or {}

    cfg["environment"] = os.getenv("TASKFLOW_ENV", cfg.get("environment", "dev"))
    cfg.setdefault("namespace", os.getenv("TASKFLOW_NAMESPACE", "taskflow"))
    return cfg