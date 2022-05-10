module "eks" {
  source                         = "../../eks"
  name                           = "aparavi-example"
  master_version                 = "1.22"
  cluster_endpoint_public_access = true
  subnet_ids                     = var.subnet_ids
  instance_types                 = ["t3.2xlarge"]
  min_size                       = 2
  max_size                       = 2
  desired_size                   = 2
}
