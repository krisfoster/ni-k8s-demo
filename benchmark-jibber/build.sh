#!/usr/bin/env bash

# Check that the REPO_PATH variable is defined
if [ -z ${REPO_PATH+y} ]; then
    echo "\$REPO_PATH env variable not defined"
    echo "Run the script in root of project: source ./script/get-repo-path.sh"
    exit 1
fi

# Build the benchmark benchmarks and push them to the container reg
mvn clean package -Ddocker-repository=${REPO_PATH}
docker push ${REPO_PATH}:jibber.openjdk.latest
docker push ${REPO_PATH}:transform.openjdk.latest

# Build the Native Image Container benchmark and push them to the container reg
mvn package -Ddocker-repository=${REPO_PATH} -Ddocker-file=Dockerfiles/Dockerfile.native -Dbase-image-tag=native -Pnative
docker push ${REPO_PATH}:jibber.native.latest
docker push ${REPO_PATH}:transform.native.latest

# Build the GraalVM EE JIT Image and push them to the container reg
mvn package -Ddocker-repository=${REPO_PATH} -Ddocker-file=Dockerfiles/Dockerfile.graalee -Dbase-image-tag=graalee
docker push ${REPO_PATH}:jibber.graalee.latest
docker push ${REPO_PATH}:transform.graalee.latest