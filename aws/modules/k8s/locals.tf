locals {
  
  bucket_name = replace(var.domain, ".", "-")

  key_name = replace("${var.region}_${var.cluster_name}_${var.name}", ".", "_")
  
}