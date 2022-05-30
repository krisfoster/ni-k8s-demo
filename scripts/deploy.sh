#!/usr/bin/env bash

# Check that the REPO_PATH variable is defined
if [ -z ${REPO_PATH+y} ]; then
    echo "\$REPO_PATH env variable not defined"
    exit 1
fi

# Deploy base infra to k8s
kubectl apply -f k8s/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml
kubectl apply -f k8s/dashboard-admin.yaml
kubectl apply -f k8s/clusterRole.yaml
kubectl apply -f k8s/prom-config-map.yaml
kubectl apply -f k8s/prom-deployment.yaml
kubectl apply -f k8s/grafana-config-map.yaml
kubectl apply -f k8s/grafana-deployment.yaml

# Build the benchmark benchmarks and push them to the container reg
mvn clean package -Ddocker-repository=${REPO_PATH}
docker push ${REPO_PATH}:jibber.openjdk.latest

# Build the Native Image Container benchmark and push them to the container reg
mvn clean package -Ddocker-repository=${REPO_PATH} -Ddocker-file=Dockerfiles/Dockerfile.native -Dbase-image-tag=native -Pnative
docker push ${REPO_PATH}:jibber.native.latest

# Build the GraalVM EE JIT Image and push them to the container reg
mvn clean package -Ddocker-repository=${REPO_PATH} -Ddocker-file=Dockerfiles/Dockerfile.graalee -Dbase-image-tag=graalee
docker push ${REPO_PATH}:jibber.graalee.latest

# Deploy the Jibber benchmark
kubectl create -f benchmark-jibber/k8s/namespace.yaml

# Deploy the containers to k8s
cat benchmark-jibber/k8s/jibber-openjdk.yaml | envsubst | kubectl create -f -
cat benchmark-jibber/k8s/jibber-native.yaml  | envsubst | kubectl create -f -
cat benchmark-jibber/k8s/jibber-graalee.yaml | envsubst | kubectl create -f -

# Deploy the stress testing container
kubectl create -f benchmark-jibber/k8s/stress-test-job.yaml
