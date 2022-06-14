module "network" {
  source = "../modules/network"
  name   = var.name
  labels = var.labels
  region = var.region
}

module "gke" {
  source       = "./modules/gke"
  name         = var.name
  labels       = var.labels
  region       = var.region
  zone         = var.zone
  machine_type = var.gke_machine_type
  network      = module.network.network_name
}

module "cloudsql" {
  source  = "../modules/cloudsql"
  name    = var.name
  labels  = var.labels
  region  = var.region
  zone    = var.zone
  network = module.network.network_id
  tier    = var.cloudsql_tier
}

data "google_client_config" "current" {}

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke.endpoint}"
    token                  = data.google_client_config.current.access_token
    cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
}

locals {
  aggregator_node_name = coalesce(
    var.aggregator_node_name,
    "${var.name}-aggregator"
  )
  collector_node_name = coalesce(
    var.collector_node_name,
    "${var.name}-collector"
  )
}

module "aparavi" {
  source = "../../aparavi-helm"

  name                 = "aparavi"
  chart_version        = "0.15.0"
  mysql_hostname       = module.cloudsql.address
  mysql_username       = module.cloudsql.username
  mysql_password       = module.cloudsql.password
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  aggregator_node_name = local.aggregator_node_name
  collector_node_name  = local.collector_node_name
  generate_sample_data = var.generate_sample_data

  depends_on = [module.gke, module.cloudsql]
}
