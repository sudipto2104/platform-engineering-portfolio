import os


class Config:
    APP_NAME = "taskflow-api"
    DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///taskflow.db")
    SECRET_KEY = os.getenv("SECRET_KEY", "dev-only-change-me")
    JSON_SORT_KEYS = False