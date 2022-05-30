output "cluster-id" {
    description = "The OCID for the newly created K8s cluster"
    value = oci_containerengine_cluster.generated_oci_containerengine_cluster.id
}
output "region" {
    description = ""
    value = var.region
}
output "os_namespace" {
    description = "The Object Storage namespace of the tenancy"
    value = data.oci_objectstorage_namespace.os_ns.namespace
}
output repo_name {
    description = ""
    value = var.container_repository_display_name
}
output "region_key" {
    description = "The luna lab region's key (3 letter region code). Example: PHX"
    value = lower(data.oci_identity_region_subscriptions.my_region_subscriptions.region_subscriptions[0].region_key)
}