#!/usr/bin/env bash

# Check that the REPO_PATH variable is defined
if [ -z ${REPO_PATH+y} ]; then
    echo "\$REPO_PATH env variable not defined"
    echo "Run the script in root of project: source ./script/get-repo-path.sh"
    exit 1
fi

#JAR_SIZE=`ls -lh target/benchmark-jibber-0.0.1-SNAPSHOT-exec.jar | awk '{print $5}' | sed 's/M//'`
#JDK_IMG_SIZE=`docker inspect -f "{{ .Size }}" ${REPO_PATH}:jibber.openjdk.latest | numfmt --to=si | sed 's/.$//'`

JAR_SIZE=`ls -lh target/benchmark-jibber-0.0.1-SNAPSHOT.jar | awk '{print $5}' | sed 's/M//'`
JDK_IMG_SIZE=`docker inspect -f "{{ .Size }}" ${REPO_PATH}:jibber.openjdk.latest | numfmt --to=si | sed 's/.$//'`

# Chart of the image sizes
echo "JAR ${JAR_SIZE}
    JDK-Container ${JDK_IMG_SIZE}" \
    | termgraph --title "Container Size" --width 60 --color {green,} --suffix " MB"

