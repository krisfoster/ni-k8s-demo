#!/usr/bin/env bash
kubectl create -f k8s/jibber-openjdk.yaml
kubectl create -f k8s/jibber-native.yaml
