############################
# SERVICE ACCOUNT (OPTIONAL)
############################
# Note: The user running aparavi_form needs to have the IAM Admin role assigned to them before you can do this.
# resource "google_service_account" "instance_admin" { 
#  account_id   = "instance-admin"
#  display_name = "instance s-account"
#  }
# resource "google_project_iam_binding" "instance_sa_iam" {
#  project = data.google_client_config.current.project # < PROJECT ID>
#  role    = "roles/compute.instanceAdmin.v1"
#  members = [
#    "serviceAccount:${google_service_account.instance_admin.email}"
#  ]

#################
# VPC
#################

resource "google_compute_network" "aparavi-vpc" {
  project                 = data.google_client_config.current.project
  name                    = "aparavi-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}

#################
# SUBNET
#################
resource "google_compute_subnetwork" "aparavi_sub" {
  name                     = "aparavi-sub"
  ip_cidr_range            = var.subnet_cidr
  region                   = var.region
  network                  = google_compute_network.aparavi-vpc.name
  description              = "This is a custom subnet for Aparavi apps"
  private_ip_google_access = "true"
  #log_config {
  #  aggregation_interval = "INTERVAL_10_MIN"
  #  flow_sampling        = 0.5
  #  metadata             = "INCLUDE_ALL_METADATA"
  #}   

  #  secondary_ip_range {
  #              range_name    = "subnet-01-secondary-01"
  #              ip_cidr_range = "192.168.64.0/24"
  #          }


}
######################
# Firewall
######################    
# web network tag
resource "google_compute_firewall" "aparavi-bastion-ssh" {
  project     = data.google_client_config.current.project # you can Replace this with your project ID in quotes var.project_id
  name        = "allow-ssh-rule-bastion"
  network     = google_compute_network.aparavi-vpc.name
  description = "Creates firewall rule to allow ssh to bastion host"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastion"]
  timeouts {}
}

resource "google_compute_firewall" "aparavi-monitoring-web" {
  project     = data.google_client_config.current.project # you can Replace this with your project ID in quotes var.project_id
  name        = "allow-ssh-rule-monitoring"
  network     = google_compute_network.aparavi-vpc.name
  description = "Creates firewall rule to allow http to monitoring host"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["monitoring"]
  timeouts {}
}

resource "google_compute_firewall" "aparavi-app-ssh" {
  project     = data.google_client_config.current.project # you can Replace this with your project ID in quotes var.project_id
  name        = "allow-ssh-rule-app"
  network     = google_compute_network.aparavi-vpc.name
  description = "Creates firewall rule to allow ssh to local addresses of app"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["10.105.10.53/32"]
  target_tags   = ["aparavi-app"]
  timeouts {}
}

resource "google_compute_firewall" "aparavi-app-appagent" {
  project     = data.google_client_config.current.project # you can Replace this with your project ID in quotes var.project_id
  name        = "allow-dataport-rule-local"
  network     = google_compute_network.aparavi-vpc.name
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol = "tcp"
    ports    = ["9752", "9745"]
  }
  source_ranges = ["10.105.10.0/24"]
  target_tags   = ["aparavi-app"]
  timeouts {}
}
resource "google_compute_firewall" "aparavi-app-node_exporter" {
  project     = data.google_client_config.current.project # you can Replace this with your project ID in quotes var.project_id
  name        = "allow-node-exporter-rule-local"
  network     = google_compute_network.aparavi-vpc.name
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol = "tcp"
    ports    = ["9100"]
  }
  source_ranges = ["10.105.10.0/24"]
  target_tags   = ["aparavi-app"]
  timeouts {}
}

output "project" {
  value = data.google_client_config.current.project
}