# TaskFlow Full Stack — kubectl Runbook

## Deploy entire stack

```bash
kubectl apply -f deliverables/
kubectl get all -n taskflow
kubectl get pvc -n taskflow
```

## Verify DNS service discovery

```bash
kubectl logs -n taskflow -l app=taskflow-api --tail=30
# Look for: K8s DNS targets — DATABASE_URL=postgresql://...@postgres:5432/...
kubectl exec -n taskflow deploy/taskflow-api -- nslookup postgres
kubectl exec -n taskflow deploy/taskflow-api -- nslookup redis
```

## Access frontend

```bash
minikube service taskflow-ui -n taskflow --url
# Or: http://$(minikube ip):30080
curl -s http://$(minikube ip):30080/ | head
kubectl port-forward -n taskflow svc/taskflow-api 8080:8080
curl localhost:8080/health
```

## Operations

```bash
kubectl scale deployment/taskflow-api -n taskflow --replicas=3
kubectl rollout restart deployment/taskflow-ui -n taskflow
kubectl describe pod -n taskflow -l app=taskflow-api
kubectl get endpoints -n taskflow
kubectl delete namespace taskflow
```

## Build week8 API image (with startup logging)

```bash
eval $(minikube docker-env)
docker build -f ../../07-introduction-containers-docker/lab-dockerfile-containerization/solutions/Dockerfile.backend \
  -t taskflow-api:week8 ../../taskflow-k8s/backend
```