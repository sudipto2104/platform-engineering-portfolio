# Ingress, TLS & HPA Guide

## Nginx Ingress 1.12+

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx --create-namespace
kubectl apply -f deliverables/ingress.yaml
```

## TLS options

| Method | File |
|--------|------|
| cert-manager + Let's Encrypt | `certificate.yaml` |
| Self-signed (Minikube lab) | `tls-secret-selfsigned.yaml` |

## HPA

```bash
kubectl apply -f deliverables/hpa-api.yaml -f deliverables/hpa-ui.yaml
kubectl get hpa -n taskflow-prod
kubectl run -n taskflow-prod load --image=busybox -- stress -c 4
```

Requires metrics-server: `minikube addons enable metrics-server`