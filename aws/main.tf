module "k8s" {

  source = "./modules/k8s"

  region = var.region

  cluster_name = "morsley-io"
  cluster_size = 1



}