#!/usr/bin/env bash

# Build OpenJDK Image
mvn clean package

# Build GraalVM EE Image
mvn package -Pgraalee

# Build native image EE Image
mvn package -Pnative

# Build native image EE + G1 Image
mvn package -Pnative -Dbase-image-tag=native-g1 -Dnative-image-extra-flags="--gc=G1"

# Build instrumented binary for profiling
mvn package -Pnative -Ddockerfile.skip -Dnative-image-extra-flags="--gc=G1 --pgo-instrument"

# Build PGO native image EE + G1 Image
mvn package -Pnative-pgo -Dbase-image-tag=native-pgo