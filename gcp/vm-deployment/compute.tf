
#####################  
# PROJECT DATA SOURCE
#####################

data "google_client_config" "current" {

}
#variable "project_id" {
#  default = data.google_client_config.current.project 
#}
#############
# Instances
#############

 resource "google_compute_instance" "aparavi_instance_collector" {
  name     = var.instances_name_collector
  hostname = var.hostname_collector
  project  = data.google_client_config.current.project
  zone     = var.zone 
  machine_type = var.vm_type
  
  metadata = {
   ssh-keys = "${var.admin}:${file("~/.ssh/id_rsa_aparavi.pub")}"   # Change Me
    startup-script        = ("${file(var.user_data_collector)}")
    #startup-script        = (templatefile("../debian_userdata_collector.sh", local.vars))
  #  startup-script-custom = "stdlib::info Hello World"
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
      image = "debian-11-bullseye-v20220406"      #"debian-cloud/debian-11"
    }
  }
 # scratch_disk {
  #  interface = "SCSI"
  #}

scheduling {
  on_host_maintenance = "MIGRATE"
  automatic_restart   =  true
}


# service account
  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
 tags = ["aparavi-app"]
} 

resource "google_compute_instance" "aparavi_instance_aggregator" {
  name     = var.instances_name_aggregator
  hostname = var.hostname_aggregator
  project  = data.google_client_config.current.project
  zone     = var.zone 
  machine_type = var.vm_type
  
  metadata = {
   ssh-keys = "${var.admin}:${file("~/.ssh/id_rsa_aparavi.pub")}"   # Change Me
    #startup-script        = ("${file(var.user_data_aggregator)}")
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
      image = "debian-11-bullseye-v20220406"      #"debian-cloud/debian-11"
    }
  }
 # scratch_disk {
  #  interface = "SCSI"
  #}

scheduling {
  on_host_maintenance = "MIGRATE"
  automatic_restart   =  true
}


# service account
  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
 tags = ["aparavi-app"]
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

#resource "google_compute_address" "static" {
#  name = "ipv4-address"
#}
 
  
output "ip_collector" {
 value = google_compute_instance.aparavi_instance_collector.network_interface.0.access_config.0.nat_ip
}

output "ip_aggregator" {
 value = google_compute_instance.aparavi_instance_aggregator.network_interface.0.access_config.0.nat_ip
}




 data "template_file" "cloudsql_tmpl_aggregator" {
   template = file("cloud-init/debian_userdata_aggregator.sh")
   vars = {
     db_addr = "${module.mysql.master_private_ip_address}"
     db_user = "${var.master_user_name}"
     db_passwd = "${var.master_user_password}"
     parentId = "${var.parentid}"
   }
  depends_on = [ module.mysql.google_sql_database_instance

  ]
 }