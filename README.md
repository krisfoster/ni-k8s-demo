# Building

We are going to build inside docker images - this is to allow for the fact that users of this repo
may be running on an OS other than linux. If you were to build on your native OS (Say Windows or OSX)
`native-image` would build an exe for your OS and that wouldn't work on linux, which is how we are going to package
and run this (inside containers running in a K8s cluster).

So, if you are running on OSX / Windows, you need to ensure that the VM you are using to run docker / podman has sufficient
resources. We would recommend at least 4 cores and a minimum of 16GB memory.

Another thing to note is the use of the builder image. As we are building inside a docker container and are using the
maven tooling to generate the native executable, maven will need to be inside our container. WHich means that when maven
runs it will need access to the cache of dependencies. On