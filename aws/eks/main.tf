module "aparavi-eks" {
  source = "../../modules/aws/aparavi-eks"

  name                      = var.name
  tags                      = var.tags
  eks_instance_types        = var.eks_instance_types
  rds_instance_class        = var.rds_instance_class
  rds_allocated_storage     = var.rds_allocated_storage
  rds_max_allocated_storage = var.rds_max_allocated_storage
  aparavi_chart_version     = var.aparavi_chart_version
  platform_host             = var.platform_host
  platform_node_id          = var.platform_node_id
  aggregator_node_name      = var.aggregator_node_name
  collector_node_name       = var.collector_node_name
  generate_sample_data      = var.generate_sample_data
  data_ebs_volume_id        = var.data_ebs_volume_id
}
