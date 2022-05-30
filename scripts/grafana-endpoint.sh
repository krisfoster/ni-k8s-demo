#!/usr/bin/env bash

# Test the endpoint
for IP in `kubectl get svc -n monitoring --field-selector metadata.name=grafana -o json | jq '.items[].status.loadBalancer.ingress[].ip'  | tr -d '"'`; do
    echo "http://${IP}:3000"
done
