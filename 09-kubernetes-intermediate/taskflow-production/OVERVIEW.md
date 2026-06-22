# TaskFlow Production Patterns (Week 9)

| Concern | Lab | Artifact |
|---------|-----|----------|
| Multi-env deploy | Helm | `values-{dev,staging,production}.yaml` |
| External access | Ingress | `ingressClassName: nginx` + TLS |
| Scale | HPA | CPU/memory targets on API/UI |
| Isolation | RBAC | Per-env namespaces + least privilege |

Images: `taskflow-api:week8`, `taskflow-ui:week7` (from Week 7/8 Minikube builds).