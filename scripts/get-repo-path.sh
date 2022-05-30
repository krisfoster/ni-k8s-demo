#!/usr/bin/env bash

export REPO_REGION_KEY=`terraform output region_key | tr -d '"'`
export REPO_OS_NAME=`terraform output os_namespace | tr -d '"'`
export REPO_NAME=`terraform output repo_name | tr -d '"'`
export REPO_PATH=${REPO_REGION_KEY}.ocir.io/${REPO_OS_NAME}/${REPO_NAME}
echo $REPO_PATH