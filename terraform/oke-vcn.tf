resource "oci_core_vcn" "generated_oci_core_vcn" {
	cidr_block = "10.0.0.0/16"
	compartment_id = var.compartment_ocid
	display_name = "oke-vcn-quick-cluster2"
	# dns_label = "cluster2"
}

resource "oci_core_internet_gateway" "generated_oci_core_internet_gateway" {
	compartment_id = var.compartment_ocid
	display_name = "oke-igw-quick-cluster2"
	enabled = "true"
	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_nat_gateway" "generated_oci_core_nat_gateway" {
	compartment_id = var.compartment_ocid
	display_name = "oke-ngw-quick-cluster2"
	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

// Moved
resource "oci_core_service_gateway" "generated_oci_core_service_gateway" {
	compartment_id = var.compartment_ocid
	display_name = "oke-sgw-quick-cluster2"
	services {
		service_id = data.oci_core_services.all_oci_services.services[0].id
	}
	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

// From Greg: https://github.com/gregvers/oke-vcn/blob/main/oke-vcn.tf
data "oci_core_services" "all_oci_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

resource "oci_core_subnet" "service_lb_subnet" {
	cidr_block = "10.0.20.0/24"
	compartment_id = var.compartment_ocid
	display_name = "oke-svclbsubnet-quick-cluster2-regional"
	# dns_label = "lbsub4e24b3776"
	prohibit_public_ip_on_vnic = "false"
	route_table_id = oci_core_default_route_table.generated_oci_core_default_route_table.id
	security_list_ids = [oci_core_vcn.generated_oci_core_vcn.default_security_list_id]
	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_subnet" "node_subnet" {
	cidr_block = "10.0.10.0/24"
	compartment_id = var.compartment_ocid
	display_name = "oke-nodesubnet-quick-cluster2-regional"
	# dns_label = "subeb338bcf3"
	prohibit_public_ip_on_vnic = "true"
	route_table_id = oci_core_route_table.generated_oci_core_route_table.id
	security_list_ids = [oci_core_security_list.node_sec_list.id]
	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_subnet" "kubernetes_api_endpoint_subnet" {
	cidr_block = "10.0.0.0/28"
	compartment_id = var.compartment_ocid
	display_name = "oke-k8sApiEndpoint-subnet-quick-cluster2-regional"
	# dns_label = "sub13747d9ab"
	prohibit_public_ip_on_vnic = "false"
	route_table_id = oci_core_default_route_table.generated_oci_core_default_route_table.id
	security_list_ids = [oci_core_security_list.kubernetes_api_endpoint_sec_list.id]
	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_route_table" "generated_oci_core_route_table" {
	compartment_id = var.compartment_ocid
	display_name = "oke-private-routetable-cluster2"
	route_rules {
		description = "traffic to the internet"
		destination = "0.0.0.0/0"
		destination_type = "CIDR_BLOCK"
		network_entity_id = oci_core_nat_gateway.generated_oci_core_nat_gateway.id
	}
	route_rules {
		description = "traffic to OCI services"
		destination = data.oci_core_services.all_oci_services.services[0].cidr_block
		destination_type = "SERVICE_CIDR_BLOCK"
		network_entity_id = oci_core_service_gateway.generated_oci_core_service_gateway.id
	}
	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_default_route_table" "generated_oci_core_default_route_table" {
	display_name = "oke-public-routetable-cluster2"
	route_rules {
		description = "traffic to/from internet"
		destination = "0.0.0.0/0"
		destination_type = "CIDR_BLOCK"
		network_entity_id = oci_core_internet_gateway.generated_oci_core_internet_gateway.id
	}
	manage_default_resource_id = oci_core_vcn.generated_oci_core_vcn.default_route_table_id
}

resource "oci_core_security_list" "service_lb_sec_list" {
	compartment_id = var.compartment_ocid
	display_name = "oke-svclbseclist-quick-cluster2"
	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_security_list" "node_sec_list" {
	compartment_id = var.compartment_ocid
	display_name = "oke-nodeseclist-quick-cluster2"
	egress_security_rules {
		description = "Allow pods on one worker node to communicate with pods on other worker nodes"
		destination = "10.0.10.0/24"
		destination_type = "CIDR_BLOCK"
		protocol = "all"
		stateless = "false"
	}
	egress_security_rules {
		description = "Access to Kubernetes API Endpoint"
		destination = "10.0.0.0/28"
		destination_type = "CIDR_BLOCK"
		protocol = "6"
		stateless = "false"
	}
	egress_security_rules {
		description = "Kubernetes worker to control plane communication"
		destination = "10.0.0.0/28"
		destination_type = "CIDR_BLOCK"
		protocol = "6"
		stateless = "false"
	}
	egress_security_rules {
		description = "Path discovery"
		destination = "10.0.0.0/28"
		destination_type = "CIDR_BLOCK"
		icmp_options {
			code = "4"
			type = "3"
		}
		protocol = "1"
		stateless = "false"
	}
	egress_security_rules {
		description = "Allow nodes to communicate with OKE to ensure correct start-up and continued functioning"
		destination = data.oci_core_services.all_oci_services.services[0].cidr_block
		destination_type = "SERVICE_CIDR_BLOCK"
		protocol = "6"
		stateless = "false"
	}
	egress_security_rules {
		description = "ICMP Access from Kubernetes Control Plane"
		destination = "0.0.0.0/0"
		destination_type = "CIDR_BLOCK"
		icmp_options {
			code = "4"
			type = "3"
		}
		protocol = "1"
		stateless = "false"
	}
	egress_security_rules {
		description = "Worker Nodes access to Internet"
		destination = "0.0.0.0/0"
		destination_type = "CIDR_BLOCK"
		protocol = "all"
		stateless = "false"
	}
	ingress_security_rules {
		description = "Allow pods on one worker node to communicate with pods on other worker nodes"
		protocol = "all"
		source = "10.0.10.0/24"
		stateless = "false"
	}
	ingress_security_rules {
		description = "Path discovery"
		icmp_options {
			code = "4"
			type = "3"
		}
		protocol = "1"
		source = "10.0.0.0/28"
		stateless = "false"
	}
	ingress_security_rules {
		description = "TCP access from Kubernetes Control Plane"
		protocol = "6"
		source = "10.0.0.0/28"
		stateless = "false"
	}
	ingress_security_rules {
		description = "Inbound SSH traffic to worker nodes"
		protocol = "6"
		source = "0.0.0.0/0"
		stateless = "false"
	}
	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}

resource "oci_core_security_list" "kubernetes_api_endpoint_sec_list" {
	compartment_id = var.compartment_ocid
	display_name = "oke-k8sApiEndpoint-quick-cluster2"
	egress_security_rules {
		description = "Allow Kubernetes Control Plane to communicate with OKE"
		destination = data.oci_core_services.all_oci_services.services[0].cidr_block
		destination_type = "SERVICE_CIDR_BLOCK"
		protocol = "6"
		stateless = "false"
	}
	egress_security_rules {
		description = "All traffic to worker nodes"
		destination = "10.0.10.0/24"
		destination_type = "CIDR_BLOCK"
		protocol = "6"
		stateless = "false"
	}
	egress_security_rules {
		description = "Path discovery"
		destination = "10.0.10.0/24"
		destination_type = "CIDR_BLOCK"
		icmp_options {
			code = "4"
			type = "3"
		}
		protocol = "1"
		stateless = "false"
	}
	ingress_security_rules {
		description = "External access to Kubernetes API endpoint"
		protocol = "6"
		source = "0.0.0.0/0"
		stateless = "false"
	}
	ingress_security_rules {
		description = "Kubernetes worker to Kubernetes API endpoint communication"
		protocol = "6"
		source = "10.0.10.0/24"
		stateless = "false"
	}
	ingress_security_rules {
		description = "Kubernetes worker to control plane communication"
		protocol = "6"
		source = "10.0.10.0/24"
		stateless = "false"
	}
	ingress_security_rules {
		description = "Path discovery"
		icmp_options {
			code = "4"
			type = "3"
		}
		protocol = "1"
		source = "10.0.10.0/24"
		stateless = "false"
	}
	vcn_id = oci_core_vcn.generated_oci_core_vcn.id
}
