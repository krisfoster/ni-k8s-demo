#!/usr/bin/env bash

# Create a secret in k8s to hold the path to the container registry rpository.
# This will vary if you are using OCI as the region and the tenancy appear in the repository
# path. We can then reference the secret as an env var in the k8s config#
#echo -n ${REPO_PATH} | base64 > repo_path
#kubectl create secret generic jibber-env --from-file=./repo_path -n jibber

#
kubectl create -f k8s/namespace.yaml

# Deploy the containers to k8s
cat k8s/jibber-openjdk.yaml | envsubst | kubectl create -f -
cat k8s/jibber-native.yaml  | envsubst | kubectl create -f -
cat k8s/jibber-graalee.yaml | envsubst | kubectl create -f -

# Deploy the stress testing container
kubectl create -f k8s/stress-test-job.yaml
