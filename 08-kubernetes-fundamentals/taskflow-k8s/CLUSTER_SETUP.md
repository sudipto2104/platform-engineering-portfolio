# TaskFlow on Minikube

```bash
minikube start --cpus=4 --memory=8192
eval $(minikube docker-env)

# Build Week 7 images into Minikube's Docker daemon
cd ../07-introduction-containers-docker
docker build -f lab-dockerfile-containerization/solutions/Dockerfile.backend \
  -t taskflow-api:week7 taskflow-stack/backend
docker build -f lab-dockerfile-containerization/solutions/Dockerfile.frontend \
  -t taskflow-ui:week7 taskflow-stack/frontend

kubectl cluster-info
```

Use `imagePullPolicy: IfNotPresent` so Minikube uses local images.