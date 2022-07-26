#!/usr/bin/env bash

# Check that the REPO_PATH variable is defined
if [ -z ${REPO_PATH+y} ]; then
    echo "\$REPO_PATH env variable not defined"
    echo "Run the script in root of project: source ./script/get-repo-path.sh"
    exit 1
fi

docker push ${REPO_PATH}:jibber.openjdk.latest
docker push ${REPO_PATH}:jibber.native.latest
docker push ${REPO_PATH}:jibber.graalee.latest
