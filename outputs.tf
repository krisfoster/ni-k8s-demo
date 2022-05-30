output "cluster-id" {
    description = "The OCID for the newly created K8s cluster"
    value = oci_containerengine_cluster.generated_oci_containerengine_cluster.id
}

output "region" {
    description = ""
    value = var.region
}
output tenancy_name {
    description = ""
    value = data.oci_identity_tenancy.demo_tenancy.name
}
output region_key {
    description = ""
    value = data.oci_identity_tenancy.demo_tenancy.home_region_key
}
output repo_name {
    description = ""
    value = var.container_repository_display_name
}