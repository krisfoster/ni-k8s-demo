#!/usr/bin/env bash

kubectl create -f k8s/namespace.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
kubectl create -f k8s/dashboard-admin.yaml
kubectl create -f k8s/clusterRole.yaml
#
kubectl create -f k8s/prom-config-map.yaml
kubectl create -f k8s/prom-deployment.yaml
kubectl create -f k8s/grafana-config-map.yaml
kubectl create -f k8s/grafana-deployment.yaml


