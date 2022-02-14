#!/usr/bin/env bash


minikube addons enable registry

kubectl get service --namespace kube-system

#docker run --rm -it --network=host alpine ash -c "apk add socat && socat TCP-LISTEN:5000,reuseaddr,fork TCP:$(minikube ip):5000"
kubectl port-forward --namespace kube-system service/registry 5000:80 &
docker run --rm -it --network=host alpine ash -c "apk add socat && socat TCP-LISTEN:5000,reuseaddr,fork TCP:host.docker.internal:5000" &

eval $(minikube docker-env)

echo "Already there?"

curl -s localhost:5000/v2/_catalog | jq
