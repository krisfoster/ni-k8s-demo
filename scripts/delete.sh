#!/usr/bin/env bash

kubectl delete  -f k8s/namespace.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
kubectl delete -f k8s/dashboard-admin.yaml
kubectl delete -f k8s/clusterRole.yaml
#
kubectl delete -f k8s/prom-config-map.yaml
kubectl delete -f k8s/prom-deployment.yaml
kubectl delete -f k8s/grafana-config-map.yaml
kubectl delete -f k8s/grafana-deployment.yaml


