#!/usr/bin/env bash

# Check that the REPO_PATH variable is defined
if [ -z ${REPO_PATH+y} ]; then
    echo "\$REPO_PATH env variable not defined"
    echo "Run the script in root of project: source ./script/get-repo-path.sh"
    exit 1
fi

# Build the Native Image Container benchmark and push them to the container reg
# You can change repository path for container with : -Ddocker-repository=${REPO_PATH}
mvn package -Ddocker-file=Dockerfiles/Dockerfile.native -Dbase-image-tag=native -Pnative
