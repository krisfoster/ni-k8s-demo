###
### Credits: Adao Junior's Mushop example
### https://github.com/oracle-quickstart/oci-cloudnative/blob/master/deploy/complete/terraform/oke-datasources.tf
###

resource "oci_containerengine_node_pool" "create_node_pool_details0" {
 	cluster_id = oci_containerengine_cluster.generated_oci_containerengine_cluster.id
 	compartment_id = var.compartment_ocid
 	freeform_tags = {
 		"OKEnodePoolName" = var.oke_node_pool_name
 	}
 	initial_node_labels {
 		key = "name"
 		value = var.oke_cluster_name
 	}
 	kubernetes_version = local.node_pool_k8s_latest_version
 	name = var.oke_node_pool_name
 	node_config_details {
 		freeform_tags = {
 			"OKEnodePoolName" = var.oke_node_pool_name
 		}
 		dynamic "placement_configs" {
 			for_each = data.oci_identity_availability_domains.ADs.availability_domains
 			content {
 				availability_domain = placement_configs.value.name
 				subnet_id = oci_core_subnet.node_subnet.id
 			}
 		}
# 		# placement_configs {
# 		# 	availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
# 		# 	subnet_id = oci_core_subnet.node_subnet.id
# 		# }
# 		# placement_configs {
# 		# 	availability_domain = "UxfD:PHX-AD-2"
# 		# 	subnet_id = oci_core_subnet.node_subnet.id
# 		# }
# 		# placement_configs {
# 		# 	availability_domain = "UxfD:PHX-AD-3"
# 		# 	subnet_id = oci_core_subnet.node_subnet.id
# 		# }
 		size = var.oke_node_pool_size
 	}
 	node_shape = var.oke_node_pool_shape
 	node_shape_config {
 		memory_in_gbs = var.oke_node_memory_in_gbs
 		ocpus = var.oke_node_ocpus
 	}
 	node_source_details {
 		image_id = lookup(data.oci_core_images.node_pool_images.images[0], "id")
 		source_type = "IMAGE"
 	}
 	timeouts {
        create = "30m"
    }
}
