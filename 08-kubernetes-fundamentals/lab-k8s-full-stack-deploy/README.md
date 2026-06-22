# Lab: TaskFlow Full Stack on Kubernetes (Capstone)

Deploy all four tiers in namespace `taskflow` — frontend NodePort, backend with DB connection logging, Postgres, Redis.

```bash
./scripts/solve.sh && ./scripts/check.sh
kubectl apply -f deliverables/
minikube service taskflow-ui -n taskflow --url
```