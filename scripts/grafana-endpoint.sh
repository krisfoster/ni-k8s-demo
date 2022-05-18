#!/usr/bin/env bash

# Test the endpoint
for IP in `kubectl get svc -n monitoring -o json | jq '.items[].status.loadBalancer.ingress[].ip' | tr -d '"'`; do 
    echo "http://${IP}:8080/jibber"
done
