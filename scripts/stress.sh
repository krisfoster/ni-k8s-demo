#!/usr/bin/env bash

TIME_TO_RUN="10m"

# Test the primes
for IP in `kubectl get svc -n apps -o json | jq '.items[].status.loadBalancer.ingress[].ip' | tr -d '"'`; do 
    hey -z ${TIME_TO_RUN} http://${IP}:8080/jibber &
done


#hey -z ${TIME_TO_RUN} http://129.153.206.183:8080/primes?upperBound=99999 &
#
#hey -z ${TIME_TO_RUN} http://152.70.143.114:8080/primes?upperBound=99999 &
#hey -c 10 -z ${TIME_TO_RUN} http://141.148.139.43:8080/primes?upperBound=99999 &
#hey -c 10 -z ${TIME_TO_RUN} http://141.148.134.234:8080/primes?upperBound=99999 &

# Test jibber
#for IP in `kubectl get svc -n apps -o json | jq '.items[].status.loadBalancer.ingress[].ip' | tr -d '"'`; do 
#    hey -c 10 -z ${TIME_TO_RUN} http://${IP}:8080/jibber/25 & 
#done

# Test the transform
#for IP in `kubectl get svc -n apps -o json | jq '.items[].status.loadBalancer.ingress[].ip' | tr -d '"'`; do 
#    hey -c 10 -z ${TIME_TO_RUN} http://${IP}:8080/transform & 
#done
