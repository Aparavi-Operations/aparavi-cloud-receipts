resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.name}-db"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = var.network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network = var.network
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private_ip_address.name
  ]
}

resource "random_pet" "db_name_suffix" {
  length = 1
}

resource "google_sql_database_instance" "this" {
  name                = "${var.name}-${random_pet.db_name_suffix.id}"
  region              = var.region
  database_version    = "MYSQL_8_0"
  deletion_protection = false


  settings {
    user_labels = var.labels
    location_preference {
      zone = var.zone
    }
    tier = var.tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "random_password" "password" {
  length  = 32
  special = false # APARAVI Data IA Installer misbehaves on some of these.
}

resource "google_sql_user" "user" {
  name     = "aparavi"
  instance = google_sql_database_instance.this.name
  host     = "%"
  password = random_password.password.result
}
