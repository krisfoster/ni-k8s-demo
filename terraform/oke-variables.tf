#*************************************
#     OKE Configuration Details
#*************************************
# OKE Cluster
# 
variable "oke_cluster_name" {
  default = "benchmark-cluster"
}

# 
# OKE Node Pool
# 
variable "oke_node_pool_name" {
  default = "benchmark-pool1"
}

variable "oke_node_pool_size" {
  default = "2"
  description = "The number of nodes in the node pool. We need a single node OKE cluster."
}

# 
# OKE Node
# 
variable "oke_node_pool_shape" {
  default = "VM.Standard.E4.Flex"
  description = "In this example, we are using a Flex shape."

}

variable "oke_node_memory_in_gbs" {
  default = 16
}

variable "oke_node_ocpus" {
  default = 4
}

variable "image_operating_system" {
  default     = "Oracle Linux"
  description = "The OS/image installed on all nodes in the node pool."
}

variable "image_operating_system_version" {
  default     = "7.9"
  description = "The OS/image version installed on all nodes in the node pool."
}

#*************************************
#     OKE Local Variables
#*************************************
locals {
  #**************************
  # OKE Kubernetes Version
  #**************************
  cluster_k8s_latest_version   = reverse(sort(data.oci_containerengine_cluster_option.oke.kubernetes_versions))[0]
  node_pool_k8s_latest_version = reverse(sort(data.oci_containerengine_node_pool_option.oke.kubernetes_versions))[0]

}