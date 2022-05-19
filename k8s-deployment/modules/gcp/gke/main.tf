module "network" {
  source = "../modules/network"
  name   = var.name
  labels = var.labels
  region = var.region
}

locals {
  cluster_secondary_range_name  = "gke-${var.name}-pods"
  services_secondary_range_name = "gke-${var.name}-services"
  master_subnet                 = "172.16.0.0/28"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name}-gke"
  region        = var.region
  network       = module.network.network_name
  ip_cidr_range = "192.168.1.0/24"

  secondary_ip_range {
    range_name    = local.cluster_secondary_range_name
    ip_cidr_range = "192.168.32.0/19"
  }
  secondary_ip_range {
    range_name    = local.services_secondary_range_name
    ip_cidr_range = "192.168.64.0/19"
  }

  private_ip_google_access = false
}

resource "google_container_cluster" "this" {
  name                     = var.name
  resource_labels          = var.labels
  location                 = var.zone
  initial_node_count       = 1
  remove_default_node_pool = true
  network                  = module.network.network_name
  subnetwork               = google_compute_subnetwork.subnet.id

  private_cluster_config {
    master_ipv4_cidr_block  = local.master_subnet
    enable_private_endpoint = false
    enable_private_nodes    = true
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = local.cluster_secondary_range_name
    services_secondary_range_name = local.services_secondary_range_name
  }
}

resource "google_container_node_pool" "default" {
  name               = "default"
  cluster            = google_container_cluster.this.id
  initial_node_count = 2

  autoscaling {
    min_node_count = 2
    max_node_count = 2
  }

  node_config {
    labels       = var.labels
    machine_type = var.gke_machine_type
  }
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
    host  = "https://${google_container_cluster.this.endpoint}"
    token = data.google_client_config.current.access_token
    cluster_ca_certificate = base64decode(
      google_container_cluster.this.master_auth.0.cluster_ca_certificate
    )
  }
}

provider "kubernetes" {
  host  = "https://${google_container_cluster.this.endpoint}"
  token = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.this.master_auth.0.cluster_ca_certificate
  )
}

module "aparavi" {
  source = "../../helm"

  name                 = var.name
  mysql_hostname       = module.cloudsql.address
  mysql_password       = module.cloudsql.password
  platform_host        = var.platform_host
  platform_node_id     = var.platform_node_id
  aggregator_node_name = var.aggregator_node_name
  collector_node_name  = var.collector_node_name
  generate_sample_data = var.generate_sample_data

  depends_on = [
    google_container_node_pool.default,
    module.cloudsql
  ]
}
