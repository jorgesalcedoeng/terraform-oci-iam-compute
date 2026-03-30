resource "oci_objectstorage_bucket" "bucket" {
  compartment_id = var.compartment_ocid
  name           = "${var.project_name}-bucket"
  namespace      = data.oci_objectstorage_namespace.ns.namespace

  freeform_tags = var.tags
}

