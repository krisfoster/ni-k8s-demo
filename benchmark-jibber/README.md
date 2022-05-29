# Spring Boot Native Image Performance Demo on K8s

## Overview

This demo / sample shows you how to build a simple micro-service using Spring Boot that is packaged and deployed as 
GraalVM Native Image executable. The benefits of deploying a native executable are much faster start-up times and reduced
memory consumption.

This will make use of [GraalVM](https://www.graalvm.org), the [Spring Native](https://docs.spring.io/spring-native/docs/current/reference/htmlsingle/)
project and the {GraalVM Native Build Tools](https://github.com/graalvm/native-build-tools).

Our micro-service will generate nonsense verse in the style of the poem Jabberwocky (by Lewis Carrol). To this remarkable
feat it uses a Markov hain to model the text of the original poem and this model is then used to generate random text 
that appear to be like the original.

# Building

We are going to build inside docker images - this is to allow for the fact that users of this repository
may be running on an OS other than linux. If you were to build on your native OS (Say Windows or OSX)
`native-image` would build an executable that si targeted for your OS and that wouldn't work on linux, which is how we 
are going to package and run this (inside Docker containers).

So, if you are running on OSX / Windows, you need to ensure that the VM you are using to run the Docker Daemon has sufficient
resources. We would recommend at least 4 cores and a minimum of 16GB memory.

Another thing to note is the use of the builder image. As we are building inside a docker container and are using the
maven tooling to generate the native executable, maven will need to be inside our container. WHich means that when maven
runs it will need access to the cache of dependencies. On

# Load Balancing

We use the OCI nnotation to add automatic loadbalancer adition:

https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengcreatingloadbalancer.htm