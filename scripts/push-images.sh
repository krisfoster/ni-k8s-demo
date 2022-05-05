#!/usr/bin/env bash

docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:openjdk.0.0.1-SNAPSHOT
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:graalee.0.0.1-SNAPSHOT
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:native.0.0.1-SNAPSHOT
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:native-g1
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:native-pgo.0.0.1-SNAPSHOT
