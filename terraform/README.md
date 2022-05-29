# Create a K8s Cluster & Container Repository on OCI

These instructions will show you how to create a K8s cluster and a public container registery in a compartment on 
Oracle Cloud (OCI).

## Prerequisites

* OCI CLI
* An account on OCI with access to a tenancy
* A compartment on OCI to deploy your k8s cluster and container repository to
* Terraform

## Installation

Change folder to the `terraform` folder.

```shell
cd terraform
```

Create a file called, `my-variables.tf`. This will hold the details of your OCI user, region, tenancy and compartment ID within OCI
that you want to create the container repository and the k8s cluster within. The following is an example - note that you 
will need to replace the placeholders with the actual OCIDs for each of these and the OCI region name:

```text
variable "tenancy_ocid" {
    default = "<OCID of your tenancy here>"
}
variable "user_ocid" {
    default = "<OCID of your OCI user here>"
}
variable "compartment_ocid" {
    default = "<OCID of your compartment within the tenancy here>"
}
variable "region" {
    default = "<OCI region name here, like: us-phoenix-1>"
}
```

The above file, `my-variables.tf`, can be thought of as your connection details.

Next we will create everything. Run the following shell commands, form the root of the code repository:

```shell
terraform init
# This creates everyting. NOTE: This may take 10 - 20 mins to complete
terraform apply
# Configure kubectl to talk to and manage your new k8s cluster - requires the OCI CLI 
./add-kubectl-config.sh
# Set shell environment variables that will hold the container repositry name
./get-repo-path.sh
```

Let' quickly test your connectivity to the new k8s cluster:

```shell
# Query the cluster to return the namespaces
kubectl get namespaces
```

You should see something like the following:

```shell
NAME              STATUS   AGE
default           Active   10m
kube-node-lease   Active   10m
kube-public       Active   10m
kube-system       Active   10m
```

Next let's check that the conatiner repository path has been retrieved correctly:

```shell
echo 
```