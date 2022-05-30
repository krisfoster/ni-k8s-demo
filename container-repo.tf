resource "oci_artifacts_container_repository" "test_container_repository" {
    #Required
    compartment_id = var.compartment_ocid
    display_name = var.container_repository_display_name

    #Optional
    is_public = var.container_repository_is_public
    readme {
        #Required
        content = var.container_repository_readme_content
        format = var.container_repository_readme_format
    }
    timeouts {
        create = "25m"
    }
}