# kubectl Guide — Lab 1

## Cluster setup

```bash
minikube start
eval $(minikube docker-env)
# build taskflow-api:week7 (see ../../taskflow-k8s/CLUSTER_SETUP.md)
```

## Deploy

```bash
kubectl apply -f deliverables/
kubectl get all -n taskflow-lab1
```

## Scale & rollout

```bash
kubectl scale deployment/taskflow-api -n taskflow-lab1 --replicas=5
kubectl set image deployment/taskflow-api api=taskflow-api:week8 -n taskflow-lab1
kubectl rollout status deployment/taskflow-api -n taskflow-lab1
kubectl rollout undo deployment/taskflow-api -n taskflow-lab1
```

## Debug

```bash
kubectl get pods -n taskflow-lab1 -o wide
kubectl describe pod -n taskflow-lab1 -l app=taskflow-api
kubectl logs -n taskflow-lab1 -l app=taskflow-api --tail=20
kubectl exec -n taskflow-lab1 deploy/taskflow-api -- curl -s localhost:8080/health
minikube service taskflow-api -n taskflow-lab1 --url   # if exposed for test
kubectl port-forward -n taskflow-lab1 svc/taskflow-api 8080:8080
```