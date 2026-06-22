# TaskFlow

Task management platform stub for the 21-week Platform Engineering bootcamp. Grows each week as new platform capabilities are added.

## Run locally

```bash
pip install -r requirements.txt
python app.py
curl http://localhost:8080/health
```

## Run in Docker

```bash
docker build -t taskflow:week1 .
docker run --rm -p 8080:8080 taskflow:week1
```