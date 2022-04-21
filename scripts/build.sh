#!/usr/bin/env bash

VER=0.1

echo "Building Java..."
#mvn clean package
echo "Building Java - DONE"

echo "Building docker containers..."
echo "Logging into OCI continer reg. Remember that the password will be the AUTH Token you created"
docker login container-registry.oracle.com

# OpenJDK container
docker build -f ./Dockerfiles/Dockerfile.jvm \
        --build-arg JAR_FILE=prime-0.0.1-SNAPSHOT.jar \
        -t localhost/demo:openjdk.0.1
docker tag localhost/demo:openjdk.0.1 phx.ocir.io/oracledeveloper/k8s-perf-demo:openjdk.0.1
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:openjdk.0.1

# GraalVM EE container
docker build -f ./Dockerfiles/Dockerfile.graalee \
          --build-arg JAR_FILE=prime-0.0.1-SNAPSHOT.jar \
          -t localhost/demo:graalee.0.1 .
docker tag localhost/demo:graalee.0.1 phx.ocir.io/oracledeveloper/k8s-perf-demo:graalee.0.1
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:graalee.0.1

# Build the builder container
docker build -f ./Dockerfiles/Dockerfile.native.builder -t localhost/demo-builder:0.1 .

# Native container
docker build -f ./Dockerfiles/Dockerfile.native \
  --build-arg PROFILE=native \
  --build-arg APP_NAME=prime \
  -t localhost/demo:native.0.1 .
docker tag localhost/demo:native.0.1 phx.ocir.io/oracledeveloper/k8s-perf-demo:native.0.1
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:native.0.1

# +G1
docker build -f ./Dockerfiles/Dockerfile.native \
  --build-arg PROFILE=native-g1 \
  --build-arg APP_NAME=prime \
  -t localhost/primes:nativeg1.0.1 .
docker tag localhost/primes:nativeg1.0.1 phx.ocir.io/oracledeveloper/k8s-perf-demo:nativeg1.0.1
docker push phx.ocir.io/oracledeveloper/k8s-perf-demo:nativeg1.0.1

# PGO Instrumentation
docker build -f ./Dockerfiles/Dockerfile.native \
  --build-arg PROFILE=native-inst \
  --build-arg APP_FILE=prime \
  -t localhost/primes:nativeinst.0.1 .

#if test -f "./target/prime-opt"; then
#    echo "Building OPTIMISED docker container for Native Image..."
#    docker build -f ./Dockerfiles/Dockerfile.native --build-arg APP_FILE=prime-opt -t localhost/primes:nativeopt.${VER} .
#    echo "Building OPTIMISED docker container for Native Image DONE"
#fi
echo "Docker docker containers - DONE"


/Users/kfoster/bin/graal/graalvm-ee-java17-22.0.0.2/Contents/Home/bin:
/usr/local/bin:
/Users/kfoster/bin:/Users/kfoster/bin/graal/graalvm-ee-java17-22.0.0.2/Contents/Home/bin:/Users/kfoster/bin:/Users/kfoster/.local/share/ponyup/bin:/usr/local/Cellar/node/15.14.0/bin/:/usr/local/Cellar/node/15.14.0//libexec/bin/:/Users/kfoster/opt/anaconda3/bin:/Users/kfoster/opt/anaconda3/condabin:/Users/kfoster/bin/graal/graalvm-ee-java17-22.0.0.2/Contents/Home/bin:/Users/kfoster/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/dotnet:/opt/X11/bin:~/.dotnet/tools:/Library/Apple/usr/bin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Applications/Xamarin Workbooks.app/Contents/SharedSupport/path-bin:/Users/kfoster/.nix-profile/bin:/Users/kfoster/.cargo/bin