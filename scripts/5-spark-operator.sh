#!/usr/bin/env bash
cd ${BASH_SOURCE%/*}

kubectl create namespace spark-operator
kubectl create namespace spark-apps

kubectl create serviceaccount spark \
 --namespace=spark-operator

kubectl create clusterrolebinding spark-operator-role \
 --clusterrole=edit \
 --serviceaccount=spark-operator:spark \
 --namespace=spark-operator

#helm repo add incubator \
# http://storage.googleapis.com/kubernetes-charts-incubator

helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

#helm install spark \
# incubator/sparkoperator \
# --skip-crds \
# --namespace spark-operator \
# --set enableWebhook=true,sparkJobNamespace=spark-apps,logLevel=3

#helm install spark spark-operator/spark-operator --namespace spark-operator --create-namespace
helm install spark \
  spark-operator/spark-operator \
  --namespace spark-operator
  --set enableWebhook=true,sparkJobNamespace=spark-apps,logLevel=3

kubectl get all -n spark-operator




