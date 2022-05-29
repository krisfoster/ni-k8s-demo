# GraalVM Native  Image Performance Demo

## Overview

The demo consists of several parts:

1. A base setup within the K8s cluster that creates:
   1. Prometheus - used for storing time series data gathered from the running instances
   2. Grafana - used to present dashboards showing the relative performance of the differing deployments
2. Individual applications that get deployed to the cluster

For each benchmark we deploy to the cluster (item 2 in the list above) we will deploy the same app in a number of 
different ways. As a Java application running on OpenJDK, as a GraalVM EE Native Image and, possibly, as a Java
application running on GraalVM EE as a JVM.

The point of this is to display the varying performance profiles of the dpeloyments. 

## Prerequisites

For this demo you will need the following software pre-installed. This demo can be deployed to an existing Kubernetes
cluster, if you don't have a Kubernetes cluster already setup you can use these [scipts][terraform/] to create one on OCI.

* OCI CLI (Command Line Interface)
* Linux - to build the images you need to be on linux. Consider running this from an OCI OL8 compute instance
* kubectl - for deploying to managing your k8s cluster
* GraalVM EE 22, with the Native Image component installed

## Installation

You will need to set some environment variables that will point to your repository that you can push the Docker images
to. It could be dockerhub, it could be a container repository on OCI. We will use an environment variable to set this:

````shell
export REPO_PATH="<INSERT-YOUR-DOCKER-REPO-PATH-HERE>"
````

> ### NOTE : For OCI Installation
> Scripts have been provided in the `terraform` folder that will set this for you - read the [README](terraform/README.md).

To deploy the base setup (Prometheus, Grafana):

```shell
./scripts/k8s-setup.sh
```

You can get the public IP endpoint for Grafana with the following scipts - allow enough time for the deployments to finish
before running:

```shell
./scripts/grafana-endpoint.sh
```

## Install the Spring Microservice Benchmark

The first of the micro benchmarks we can install is a Spring microservice. It uses a Java library to create a 
Markov model of the poem Jabberwocky, which it then 