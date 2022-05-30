#!/usr/bin/env bash
export CLUSTER_ID=`terraform output cluster-id | tr -d '"'`
export REGION=`terraform output region | tr -d '"'`

oci ce cluster create-kubeconfig --cluster-id $CLUSTER_ID --file $HOME/.kube/config \
    --region $REGION --token-version 2.0.0  --kube-endpoint PUBLIC_ENDPOINT