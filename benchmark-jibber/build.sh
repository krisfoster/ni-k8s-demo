#!/usr/bin/env bash

# Check that the REPO_PATH variable is defined
if [ -z ${REPO_PATH+y} ]; then
    echo "\$REPO_PATH env variable not defined"
    echo "Run the script in root of project: source ./script/get-repo-path.sh"
    exit 1
fi

# Build the benchmark benchmarks and push them to the container reg
# You can change repository path for container with : -Ddocker-repository=${REPO_PATH}
mvn clean package

# Build the GraalVM EE JIT Image and push them to the container reg
#mvn package -Ddocker-repository=${REPO_PATH} -Ddocker-file=Dockerfiles/Dockerfile.graalee -Dbase-image-tag=graalee
