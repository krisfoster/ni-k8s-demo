// /*
// ********************
// # Copyright (c) 2020 Oracle and/or its affiliates. All rights reserved.
// # by - Rene Fontcha - Master Principal Solutions Architect, Security and Management
// # Last Updated -05/12/2020
// ********************
// */

terraform {
  // Added on May 20, 2022 based on Sean Tuck's Slack thread:
  // https://corparch-core-srv.slack.com/archives/CUXBWJ3QF/p1652990571222729
  required_providers {
    oci = {
      source = "oracle/oci"
      version = ">= 4.21.0"
    }
  }

  required_version = ">= 0.13.0"
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  region       = var.region
}

locals {
  terraform_stack_version = "0.13"
}
