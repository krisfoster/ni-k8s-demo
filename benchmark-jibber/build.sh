#!/usr/bin/env bash

# Important  - until i get the mvn deploy working we need to push the images
# to the docker repo as a separate step. So, when you update the verion
# info for the maven file, which gets used for tagging the image, you need to  also
# updat the tags int eh docker push commands within this script

# Build the openJDK container and push it out
mvn clean package
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:jibber.openjdk.0.0.3-SNAPSHOT

# Build the Native Image Container and push it out
mvn clean package -Ddocker-file=Dockerfiles/Dockerfile.native -Dbase-image-tag=native -Pnative
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:jibber.native.0.0.3-SNAPSHOT

# Build the GraalVM EE JIT Image and push it
mvn clean package -Ddocker-file=Dockerfiles/Dockerfile.graalee -Dbase-image-tag=graalee
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:jibber.graalee.0.0.3-SNAPSHOT