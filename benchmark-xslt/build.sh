#!/usr/bin/env bash

# Build the openJDK container and push it out
mvn clean package
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:transform.openjdk.0.0.2-SNAPSHOT

# Build the Native Image Container and push it out
mvn clean package -Ddocker-file=Dockerfiles/Dockerfile.native -Dbase-image-tag=native -Pnative
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:transform.native.0.0.2-SNAPSHOT
