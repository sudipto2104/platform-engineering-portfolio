# Lab: Platform Path — End-to-End DevOps Slice

Touch one representative tool per layer and watch each hand off to the next.

## Platform layers

```
Git (source) → Docker (image) → Terraform (IaC) → Scale (replicas) → Observe (logs/state)
```

## Steps

### 1. Version control

```bash
cd ../taskflow
git init
git add .
git commit -m "feat: initial TaskFlow week1 stub"
```

### 2. Containers

```bash
docker build -t taskflow:week1 .
docker run --rm -d --name taskflow-dev -p 8080:8080 taskflow:week1
curl http://localhost:8080/api/tasks
```

### 3. Infrastructure as Code

```bash
cd ../lab-platform-path/terraform
terraform init
terraform plan -var="replica_count=1"
terraform apply -auto-approve -var="replica_count=1"
```

### 4. Orchestration (first taste — scale replicas)

```bash
terraform apply -auto-approve -var="replica_count=3"
# Or use docker compose (alternative, no Swarm required):
docker compose -f docker-compose.scale.yml up -d --build
```

### 5. Observability

```bash
./scripts/observe.sh
```

## Verify

```bash
./scripts/check.sh
```

## Solution

```bash
./scripts/solve.sh
```