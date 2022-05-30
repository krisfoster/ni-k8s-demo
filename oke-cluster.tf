resource "oci_containerengine_cluster" "generated_oci_containerengine_cluster" {
	compartment_id = var.compartment_ocid
	endpoint_config {
		is_public_ip_enabled = "true"
 		subnet_id = oci_core_subnet.kubernetes_api_endpoint_subnet.id
 	}
 	freeform_tags = {
 		"OKEclusterName" = var.oke_cluster_name
 	}
 	kubernetes_version = local.cluster_k8s_latest_version
 	name = var.oke_cluster_name
 	options {
 		admission_controller_options {
 			is_pod_security_policy_enabled = "false"
 		}
 		persistent_volume_config {
 			freeform_tags = {
 				"OKEclusterName" = var.oke_cluster_name
 			}
 		}
 		service_lb_config {
 			freeform_tags = {
 				"OKEclusterName" = var.oke_cluster_name
 			}
 		}
 		service_lb_subnet_ids = [oci_core_subnet.service_lb_subnet.id]
 	}
 	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

# Local kubeconfig for when using Terraform locally. Not used by Oracle Resource Manager
#resource "local_file" "kubeconfig" {
#  content  = data.oci_containerengine_cluster_kube_config.oke_cluster_kube_config.content
#  filename = "generated/kubeconfig"
#}
