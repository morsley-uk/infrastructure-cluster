locals {
  bucket_name = replace(var.domain, ".", "-")
}