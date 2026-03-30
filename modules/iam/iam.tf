

# Dynamic Group for instance
resource "oci_identity_dynamic_group" "dg" {
  compartment_id = local.tenancy_ocid
  name           = "${var.project_name}-dg"
  description    = "DG for instances"

  matching_rule = "ALL {instance.compartment.id = '${var.compartment_ocid}'}"

  freeform_tags = var.tags
}

# Policy to allow DG access to bucket
resource "oci_identity_policy" "dg_policy" {
  compartment_id = local.tenancy_ocid
  name           = "${var.project_name}-dg-policy"
  description    = "Allow DG to read buckets"

  statements = [
    "Allow dynamic-group ${var.project_name}-dg to read buckets in compartment id ${var.compartment_ocid}",
    "Allow dynamic-group ${var.project_name}-dg to read objects in compartment id ${var.compartment_ocid}",
    "Allow dynamic-group ${var.project_name}-dg to read objectstorage-namespaces in tenancy"
  ]
}
