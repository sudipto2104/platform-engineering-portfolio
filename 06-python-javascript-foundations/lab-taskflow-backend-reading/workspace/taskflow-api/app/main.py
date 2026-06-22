"""Application factory — startup, blueprints, extensions."""

from flask import Flask, jsonify

from app.config import Config
from app.routes.health import health_bp
from app.routes.tasks import tasks_bp


def create_app(config_class: type = Config) -> Flask:
    app = Flask(__name__)
    app.config.from_object(config_class)

    app.register_blueprint(health_bp)
    app.register_blueprint(tasks_bp, url_prefix="/api")

    @app.get("/")
    def index():
        return jsonify(
            {
                "message": "TaskFlow API",
                "endpoints": ["/health", "/api/tasks"],
            }
        )

    return app