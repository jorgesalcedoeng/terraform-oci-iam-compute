data "oci_identity_compartment" "current" {
  id = var.compartment_ocid
}

locals {
  tenancy_ocid = data.oci_identity_compartment.current.compartment_id
}