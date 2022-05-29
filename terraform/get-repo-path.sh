#!/usr/bin/env bash

REPO_REGION_KEY=`terraform output region_key | tr -d '"' | tr [:upper:] [:lower:]`
REPO_TENNANCY_NAME=`terraform output tenancy_name | tr -d '"' | tr [:upper:] [:lower:]`
REPO_NAME=`terraform output repo_name | tr -d '"' | tr [:upper:] [:lower:]`
export REPO_PATH=${REPO_REGION_KEY}.ocir.io/${REPO_TENNANCY_NAME}/${REPO_NAME}
echo $REPO_PATH