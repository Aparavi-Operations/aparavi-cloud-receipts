resource "google_compute_network" "this" {
  name                    = var.name
  auto_create_subnetworks = false
}

resource "google_compute_router" "router" {
  name    = var.name
  region  = var.region
  network = google_compute_network.this.name
}

resource "google_compute_address" "nat" {
  provider = google-beta
  name     = var.name
  region   = var.region
  labels   = var.labels
}

resource "google_compute_router_nat" "nat" {
  name                               = var.name
  region                             = var.region
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
