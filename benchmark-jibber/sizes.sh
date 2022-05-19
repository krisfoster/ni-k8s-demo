#!/usr/bin/env bash

NATIVE_SIZE=`ls -lh target/jibber | awk '{print $5}' | sed 's/M//'`
JAR_SIZE=`ls -lh target/benchmark-jibber-0.0.3-SNAPSHOT-exec.jar | awk '{print $5}' | sed 's/M//'`
JDK_IMG_SIZE=`docker inspect -f "{{ .Size }}" phx.ocir.io/oracledeveloper/k8s-perf-demo:jibber.openjdk.0.0.3-SNAPSHOT | numfmt --to=si | sed 's/.$//'`
NATIVE_IMG_SIZE=`docker inspect -f "{{ .Size }}" phx.ocir.io/oracledeveloper/k8s-perf-demo:jibber.native.0.0.3-SNAPSHOT | numfmt --to=si | sed 's/.$//'`

# Chart of the image sizes
echo "JAR ${JAR_SIZE}
    Native-Exe ${NATIVE_SIZE}
    NI-Container ${NATIVE_IMG_SIZE}
    JDK-Container ${JDK_IMG_SIZE}" \
    | termgraph --title "Container Size" --width 60 --color {green,} --suffix " MB"

