#!/usr/bin/env bash

cd ${BASH_SOURCE%/*}/..

name="transform-movie-ratings"

#mkdir output
rm -rf output/${name}
mkdir -p output/${name}
cp -r helm/ output/${name}/
cat helm/values-minikube.yaml >> output/${name}/values.yaml
cd output

export HELM_REPO_USE_HTTP="true"
helm repo add chartmuseum http://${minikube ip}:8080
#helm repo add chartmuseum localhost:8080
helm push  --force ${name}/ chartmuseum
