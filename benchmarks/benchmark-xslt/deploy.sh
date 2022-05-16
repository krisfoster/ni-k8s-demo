#!/usr/bin/env bash

#
kubectl create -f k8s/namespace.yaml

# Deploy the containers to k8s
kubectl create -f k8s/transform-openjdk.yaml
kubectl create -f k8s/transform-native.yaml
#kubectl create -f k8s/transform-graalee.yaml
#kubectl create -f k8s/transform-native-opts.yaml
