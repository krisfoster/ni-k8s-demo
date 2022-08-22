#!/usr/bin/env bash

# Check that the REPO_PATH variable is defined
if [ -z ${REPO_PATH+y} ]; then
    echo "\$REPO_PATH env variable not defined"
    echo "Run the script in root of project: source ./script/get-repo-path.sh"
    exit 1
fi

#############################
# Jibber Benchmark
#############################

# Deploy the namespace
kubectl apply -f k8s/namespace.yaml

# Deploy the containers to k8s
cat k8s/jibber-openjdk.yaml | envsubst | kubectl apply -f -
cat k8s/jibber-native.yaml  | envsubst | kubectl apply -f -
#cat k8s/jibber-graalee.yaml | envsubst | kubectl apply -f -

# Deploy the stress testing container
kubectl apply -f k8s/stress-test-job.yaml