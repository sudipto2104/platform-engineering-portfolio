# Workflow Analysis — TaskFlow Platform Team (Reference)

## Scoring method

**Automation ROI score** = (weekly frequency × minutes per run × error rate factor) / automation effort (hours)

Error rate factor: 1.0 + error_rate (e.g., 30% → 1.3)

## Workflow scores

| Workflow | Freq/week | Min/run | Error rate | ROI score | Automate? |
|----------|-----------|---------|------------|-----------|-----------|
| Onboarding setup | 2.5 | 32 | 30% | High (208) | **Yes** |
| Pre-demo health | 5 | 10 | 12% | High (280) | **Yes** |
| Post-deploy smoke | 3 | 10 | 20% | Medium (180) | **Yes** |
| Dependency audit | 1 | 5 | 10% | Low (22) | Defer |

## Top automation candidates

### 1. Onboarding (`taskflow-setup.sh`)

- **Pain:** Repeated pip/venv mistakes burn 30+ minutes per new engineer.
- **Automation:** Idempotent venv + dependency install + import verify.
- **Human kept:** Choosing IDE extensions (see `lab-dev-environment`).

### 2. Health probe (`taskflow-health.sh`)

- **Pain:** Demo failures from unchecked processes.
- **Automation:** Single command, structured log, exit code for CI hooks.
- **Human kept:** Deciding *when* to demo (judgment call).

### 3. Smoke tests (`taskflow-smoke.sh`)

- **Pain:** Missing a dead replica after Terraform scale.
- **Automation:** Probe primary + optional replica ports; skip absent replicas.
- **Human kept:** Interpreting failures that need architecture changes.

## Do not automate (yet)

| Workflow | Reason |
|----------|--------|
| Dependency audit | Low frequency; better solved in Week 17 observability |
| Slack proof screenshots | Social signal, not technical verification |
| Architecture redesign after smoke fail | Requires human decision |