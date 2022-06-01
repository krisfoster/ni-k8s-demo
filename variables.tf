/*
******************************
Basic Configuration Details
******************************
*/



/*
******************************
AD Configuration Details
******************************
*/


data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}


data "oci_limits_limit_definitions" "test_limit_definitions" {
  #Required
  compartment_id = var.tenancy_ocid
  #Optional
  service_name = "compute"
  filter {
    name   = "description"
    #values = ["VM.Standard2.4"]
    values = ["VM.Standard.E2.1"]
  }
}
data "oci_limits_resource_availability" "get_resource_availability" {
  # Required
  compartment_id = var.compartment_ocid
  limit_name     = data.oci_limits_limit_definitions.test_limit_definitions.limit_definitions[0].name
  service_name   = "compute"
  # this will create an instance for every AD
  for_each            = toset(data.oci_identity_availability_domains.ads.availability_domains[*].name)
  availability_domain = each.value
}


/*
******************************
Object Storage Namespace
******************************
*/

data "oci_objectstorage_namespace" "os_ns" {

  #Optional
  compartment_id = var.compartment_ocid
}


/*
******************************
Region Code
******************************
*/

data "oci_identity_region_subscriptions" "my_region_subscriptions" {
  #Required
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "region_name"
    values = [var.region]
  }
}

#
# Container repository
#
variable "container_repository_display_name" {
    default = "graal-demo-repo-krf"
}

variable "container_repository_is_public" {
    default = "true"
}

variable "container_repository_readme_content" {
    default = "Test Container Repo to hold the Docker Images for the Demo"
}

variable "container_repository_readme_format" {
    default = "text/plain"
}


#*************************************
#        Local Variables
#*************************************
locals {
  timestamp      = "${formatdate("YYYY-MM-DD-hhmmss", timestamp())}"

  # get the list with available resources in each AD
  usage_sizelist = [for dom in data.oci_limits_resource_availability.get_resource_availability : tonumber(dom.available)]

  # get the max number of available resources
  maxsize = max(distinct(local.usage_sizelist)...)

  # find the domains that match the max number of available resources
  selected_domain = [for dom in data.oci_limits_resource_availability.get_resource_availability : dom.availability_domain if tonumber(dom.available) == local.maxsize]

  # choose the first AD with max number of available resources
  ad = local.selected_domain[0]
}