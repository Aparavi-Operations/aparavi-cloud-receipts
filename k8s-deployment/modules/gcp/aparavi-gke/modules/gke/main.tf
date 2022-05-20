locals {
  cluster_secondary_range_name  = "gke-${var.name}-pods"
  services_secondary_range_name = "gke-${var.name}-services"
  master_subnet                 = "172.16.0.0/28"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name}-gke"
  region        = var.region
  network       = var.network
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
  network                  = var.network
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
    machine_type = var.machine_type
  }
}
