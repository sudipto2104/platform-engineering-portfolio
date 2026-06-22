"""Local dev entrypoint — production uses gunicorn app.main:app."""

from app.main import create_app

app = create_app()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(__import__("os").getenv("PORT", "8080")))