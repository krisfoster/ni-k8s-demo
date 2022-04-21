#!/usr/bin/env bash
alias docker='podman'
echo "Building the instrumented image..."
docker build -f ./Dockerfiles/Dockerfile.native -t localhost/demo-inst:0.1 .
echo "Starting image..."
docker run --name "demo-inst" --rm -d -p 8080:8080 localhost/demo-inst:0.1
echo "Stress Testing image..."
docker run --name "stess-test" --rm -d ricoli/hey -z 60m http://primes-native-g1:8080/primes?upperBound=9999
echo "Copying profile data"
docker cp