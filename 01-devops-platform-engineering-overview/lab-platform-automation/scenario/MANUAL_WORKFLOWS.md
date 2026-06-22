# Manual Workflows — TaskFlow Platform Team

Before automation, the TaskFlow platform team does the following by hand.

## Workflow 1: New developer onboarding

1. Clone the repo and `cd taskflow`
2. Run `pip install -r requirements.txt` (sometimes twice if venv wrong)
3. Start `python app.py` in a terminal
4. Open browser or run three separate `curl` commands to verify `/health`, `/`, `/api/tasks`
5. Post screenshots in Slack to prove it works

**Frequency:** 2–3 times per week (new cohort members)  
**Time:** 25–40 minutes  
**Error rate:** ~30% (wrong Python, port in use, forgot a curl)

## Workflow 2: Pre-demo health check

Before showing TaskFlow in lab reviews, an engineer:

1. Checks if anything is listening on port 8080 (`lsof` or guesswork)
2. Runs `curl http://localhost:8080/health` and eyeballs JSON
3. If down, restarts app manually and hopes it works

**Frequency:** Daily during bootcamp weeks  
**Time:** 5–15 minutes  
**Error rate:** Demo fails ~1 in 8 if rushed

## Workflow 3: Post-deploy smoke test

After `docker run` or `terraform apply`:

1. Manually try ports 9080, 9081, 9082 with curl
2. Compare JSON output across replicas
3. Copy/paste results into lab notes

**Frequency:** After every platform-path lab run  
**Time:** 10 minutes  
**Error rate:** Misses a failing replica when tired

## Workflow 4: Dependency audit

Lead engineer occasionally runs:

```bash
pip list | grep -i flask
docker images | grep taskflow
```

to answer "what version is running?" — no log, no timestamp.

**Frequency:** Weekly  
**Time:** 5 minutes  
**Pain:** Not repeatable; answers differ by who runs it

## Your automation mission

1. Score each workflow for **automation ROI** (frequency × time × error rate).
2. Automate the top candidates with **idempotent** scripts.
3. Apply **error handling**, **structured logging**, and clear **exit codes**.
4. Document workflows you intentionally keep manual and why.