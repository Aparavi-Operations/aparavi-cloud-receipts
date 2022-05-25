
#####################
# PROJECT DATA SOURCE
#####################

data "google_client_config" "current" {

}

#############
# Instances
#############

resource "google_compute_instance" "aparavi_instance_collector" {
  name         = var.instances_name_collector
  hostname     = var.hostname_collector
  project      = data.google_client_config.current.project
  zone         = var.zone
  machine_type = var.vm_type

  metadata = {
    ssh-keys       = "${var.admin}:${file("~/.ssh/id_rsa_aparavi.pub")}" # Change Me
    startup-script = file("${path.module}/cloud-init/debian_userdata_collector.sh")
  }
  network_interface {
    network            = google_compute_network.aparavi-vpc.self_link
    subnetwork         = google_compute_subnetwork.aparavi_sub.self_link
    subnetwork_project = data.google_client_config.current.project
    network_ip         = var.private_ip_collector
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  depends_on = [data.google_client_config.current]
  ######################
  # IMAGE
  ######################

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20220406" #"debian-cloud/debian-11"
    }
  }
  # scratch_disk {
  #  interface = "SCSI"
  #}

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }


  # service account
  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
  tags = ["aparavi-app", "collector"]
}

resource "google_compute_instance" "aparavi_instance_aggregator" {
  name         = var.instances_name_aggregator
  hostname     = var.hostname_aggregator
  project      = data.google_client_config.current.project
  zone         = var.zone
  machine_type = var.vm_type

  metadata = {
    ssh-keys       = "${var.admin}:${file("~/.ssh/id_rsa_aparavi.pub")}" # Change Me
    startup-script = ("${data.template_file.cloudsql_tmpl_aggregator.rendered}")
  }
  network_interface {
    network            = google_compute_network.aparavi-vpc.self_link
    subnetwork         = google_compute_subnetwork.aparavi_sub.self_link
    subnetwork_project = data.google_client_config.current.project
    network_ip         = var.private_ip_aggregator
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  depends_on = [data.google_client_config.current]

  ######################
  # IMAGE
  ######################

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20220406" #"debian-cloud/debian-11"
    }
  }
  # scratch_disk {
  #  interface = "SCSI"
  #}

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }


  # service account
  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
  tags = ["aparavi-app", "aggregator"]
}

resource "google_compute_instance" "aparavi_instance_monitoring" {
  name         = var.instance_name_monitoring
  hostname     = var.hostname_monitoring
  project      = data.google_client_config.current.project
  zone         = var.zone
  machine_type = var.vm_type_monitoring

  metadata = {
    ssh-keys       = "${var.admin}:${file("~/.ssh/id_rsa_aparavi.pub")}" # Change Me
    startup-script = ("${data.template_file.cloudsql_tmpl_monitoring.rendered}")

  }
  network_interface {
    network            = google_compute_network.aparavi-vpc.self_link
    subnetwork         = google_compute_subnetwork.aparavi_sub.self_link
    subnetwork_project = data.google_client_config.current.project
    network_ip         = var.private_ip_monitoring
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  depends_on = [data.google_client_config.current]
  ######################
  # IMAGE
  ######################

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20220406" #"debian-cloud/debian-11"
    }
  }
  # scratch_disk {
  #  interface = "SCSI"
  #}

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }


  # service account
  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
  tags = ["aparavi-app", "monitoring"]
}
resource "google_compute_instance" "aparavi_instance_bastion" {
  name         = var.instance_name_bastion
  hostname     = var.hostname_bastion
  project      = data.google_client_config.current.project
  zone         = var.zone
  machine_type = var.vm_type

  metadata = {
    ssh-keys = "${var.admin}:${file("~/.ssh/id_rsa_aparavi.pub")}" # Change Me
  }
  network_interface {
    network            = google_compute_network.aparavi-vpc.self_link
    subnetwork         = google_compute_subnetwork.aparavi_sub.self_link
    subnetwork_project = data.google_client_config.current.project
    network_ip         = var.private_ip_bastion
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  depends_on = [data.google_client_config.current]
  ######################
  # IMAGE
  ######################

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20220406" #"debian-cloud/debian-11"
    }
  }
  # scratch_disk {
  #  interface = "SCSI"
  #}

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }


  # service account
  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
  tags = ["aparavi-app", "bastion"]
}

######################
# ADDRESS
######################
# Reserving a static internal IP address
resource "google_compute_address" "internal_reserved_subnet_ip_collector" {
  name         = "internal-address-collector"
  subnetwork   = google_compute_subnetwork.aparavi_sub.id
  address_type = "INTERNAL"
  address      = var.private_ip_collector
  region       = var.region
}

# Reserving a static internal IP address
resource "google_compute_address" "internal_reserved_subnet_ip_aggregator" {
  name         = "internal-address-aggregator"
  subnetwork   = google_compute_subnetwork.aparavi_sub.id
  address_type = "INTERNAL"
  address      = var.private_ip_aggregator
  region       = var.region
}

# Reserving a static internal IP address
resource "google_compute_address" "internal_reserved_subnet_ip_bastion" {
  name         = "internal-address-bastion"
  subnetwork   = google_compute_subnetwork.aparavi_sub.id
  address_type = "INTERNAL"
  address      = var.private_ip_bastion
  region       = var.region
}

# Reserving a static internal IP address
resource "google_compute_address" "internal_reserved_subnet_ip_monitoring" {
  name         = "internal-address-monitoring"
  subnetwork   = google_compute_subnetwork.aparavi_sub.id
  address_type = "INTERNAL"
  address      = var.private_ip_monitoring
  region       = var.region
}

data "template_file" "cloudsql_tmpl_aggregator" {
  template = file("${path.module}/cloud-init/debian_userdata_aggregator.sh")
  vars = {
    platform_bind_addr = "${var.bind_addr}"
    db_addr            = "${module.mysql.master_private_ip_address}"
    db_user            = "${var.master_user_name}"
    db_passwd          = "${var.master_user_password}"
    parentId           = "${var.parentid}"
  }
  depends_on = [module.mysql.google_sql_database_instance

  ]
}

data "template_file" "cloudsql_tmpl_monitoring" {
  template = file("${path.module}/cloud-init/debian_userdata_monitoring.sh")
  vars = {
    deployment_name       = "deployment_1"
    aggregator_private_ip = "${var.private_ip_aggregator}"
    collector_private_ip  = "${var.private_ip_collector}"
    monitoring_private_ip = "${var.private_ip_monitoring}"

  }

}
