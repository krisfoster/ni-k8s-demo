#!/usr/bin/env bash

TIME_TO_RUN="2h"

# Test the endpoint
for IP in `kubectl get svc -n jibber -o json | jq '.items[].status.loadBalancer.ingress[].ip' | tr -d '"'`; do 
    hey -z ${TIME_TO_RUN} http://${IP}:8080/transform &
done
