# TaskFlow Automation Runbook

## Suite

| Script | Role |
|--------|------|
| `setup_taskflow.sh` | Orchestrator |
| `validate_env.sh` | Binary + mode checks |
| `init_services.sh` | Dependencies and service init |
| `lib/taskflow.sh` | Shared helpers |

## Sandbox quick start

```bash
cd ../../03-version-control-git-github/taskflow-sandbox
pip install -r requirements.txt
python app.py &
./setup_taskflow.sh sandbox
curl http://localhost:8080/health
```

## Full stack mode

Documents React + Node + PostgreSQL + Redis initialization (simulated locally; real deploy in later weeks).