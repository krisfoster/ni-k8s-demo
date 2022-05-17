#!/usr/bin/env bash

#
kubectl create -f k8s/namespace.yaml

# Deploy the containers to k8s
kubectl create -f k8s/jibber-openjdk.yaml
kubectl create -f k8s/jibber-native.yaml
#kubectl create -f k8s/jibber-graalee.yaml
#kubectl create -f k8s/jibber-native-opts.yaml

# Deploy the stress testing container
kubectl create -f k8s/stress-test-job.yaml
