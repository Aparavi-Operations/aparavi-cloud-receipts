module "aparavi-gke" {
  source               = "../../modules/gcp/aparavi-gke"
  name                 = var.name
  region               = var.region
  zone                 = var.zone
  labels               = var.labels
  gke_machine_type     = var.gke_machine_type
  cloudsql_tier        = var.cloudsql_tier
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  aggregator_node_name = var.aggregator_node_name
  collector_node_name  = var.collector_node_name
  generate_sample_data = var.generate_sample_data
}
