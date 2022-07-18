# Notes on Delivering this as a Talk

* Slides, start with a quick overview of what GraalVM & Native Image are
* Let's look at the code slide, switch to Visual Studio Code
    * Have the repo open and also a connection to your remote linux OCI machine
    * Already have the machine setup, see README.md
    * ALready have the k8s cluster created and have run the `scripts/deploy.sh` script
* Show the code
* Build lcoally
    * `cd benchmark-jibber`
    * `mvn clean package`
    * `java -jar target/....jar &`
    * Take a look at the time to startup
    * curl http://localhost:8080/jibber
    * kill the background process
* We have seen our app, maybe it could be interesting to look at the size of the container
    * `sizes-java.sh`
* We now have a baseline
* back to slides : 2 slides, native Executables in Containers
* This is just a break so we can say that we are going to look at Native executables in containers next, built using native image
* Can recap on what native image is
* Back to Code slide, return 
* Let's take a look at how we can use GraalVM Native Image to make our application into a native executable
* Open the `pom.xml`
    * Look at the profile
    * Notice that it builds the native executable and then paclages it into a docker container
    * Talk a little about how the native image maven tooling makes it easy to build a native executable.
    * You can ppass in all the arguments you can to native image tc.
* Build the native executable and the docker container
    * `mvn package -Pnative`
    * This also builds the native image locally, as well as packaging it into the docker container
* Run the native image - let's see if it works
    * `./target/jibber &`
    * Notice how quickly iot starts
    * `curl http://localhost:8080/jibber`
* We said that we package the native executable as a docker container, let's take a look at that
    * Look at the docker file, `dockerfile.native`
    * Uses distroless - a very small base image with very little in it
    * We use partially statically linked exexcutables. The executable has everything in it, aprt from glibc, which is provided by the container
    * less in the container, also less to hack - arguably more secure
    * Let's look at the sizes of the Java and native executable container:
    * `sizes.sh`
    * Our container is about the 1/6th of the size of the JVM container
* Let's take a look at how the two containers perform
    * We are going to deploy them to an existing K8s cluster
    * The apps have been built to support metrics
    * the k8s cluster has Prometheus &  Grafana deployed to it, in order to allow us to view the performance for various metrics
    * To deploy:
        * `./deploy.sh`
        * You may have deployed already, and see that nothing gets updated. That's ok - just say I deployed it earlier and we haven't changed anything
    * Wait for the services to come up
        * `kubectl get svc -n jibber`
        * Use the External IPs to query the endpoints, to show they are available
    * Look at the side-by-side performance through Grafana
        * `kubectl get svc -n monitoring`
        * This will let you get the External IP for Grafana
        * Open Grafana (default password and user will be required if this is your first time access the new service)
            * http://<EXTERNALIP>:3000
            * Set a new password if requested
        * To locate the dashboards: Dashboards > Brwose > Benchmarks (folder) > Jibber API
        * Compare the throughput and the RSS (Resident Set Size, unswapped memeory)
        * Same, or similar performance for native executable as for OpenJDK - but much lower memroy consumption
* Back to summary slides and end the talk - go over what we did, what are the benefits
