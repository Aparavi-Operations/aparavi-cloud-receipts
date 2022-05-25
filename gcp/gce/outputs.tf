output "vpc_name" {
  description = "The Name of the newly created vpc"
  value       = module.aparavi-gce.vpc_name
}
#output "vpc_id" {
#      description = "id of created vpc. "
#      value       = google_compute_network.aparavi_vpc.id
#    }

output "Subnet_Name" {
  description = "Name of created vpc's Subnet. "
  value       = module.aparavi-gce.Subnet_Name
}
output "Subnet_id" {
  description = "id of created vpc. "
  value       = module.aparavi-gce.Subnet_id
}
output "Subnet_CIDR" {
  description = "cidr block of vpc's Subnet. "
  value       = module.aparavi-gce.Subnet_CIDR
}

##  INSTANCE OUTPUT
output "instance_name_bastion" {
  description = " id of created bastion instance. "
  value       = module.aparavi-gce.instance_name_bastion
}

output "instance_name_collector" {
  description = " id of created collector instances. "
  value       = module.aparavi-gce.instance_name_collector
}

output "instance_name_aggregator" {
  description = " id of created collector aggregator. "
  value       = module.aparavi-gce.instance_name_aggregator
}
output "instance_name_monitoring" {
  description = " id of created collector aggregator. "
  value       = module.aparavi-gce.instance_name_monitoring
}
output "hostname_bastion" {
  description = " id of created bastion instances. "
  value       = module.aparavi-gce.hostname_bastion
}
output "hostname_collector" {
  description = " id of created collector instances. "
  value       = module.aparavi-gce.hostname_collector
}
output "hostname_aggregator" {
  description = " id of created aggregator instances. "
  value       = module.aparavi-gce.hostname_aggregator
}
output "hostname_monitoring" {
  description = " id of created monitoring instances. "
  value       = module.aparavi-gce.hostname_monitoring
}
output "private_ip_bastion" {
  description = "Private IPs of created bastion instance. "
  value       = module.aparavi-gce.private_ip_bastion
}
output "private_ip_collector" {
  description = "Private IPs of created collector instances. "
  value       = module.aparavi-gce.private_ip_collector
}
output "private_ip_aggregator" {
  description = "Private IPs of created aggregator instances. "
  value       = module.aparavi-gce.private_ip_aggregator
}
output "private_ip_monitoring" {
  description = "Private IPs of created monitoring instances. "
  value       = module.aparavi-gce.private_ip_monitoring
}
output "public_ip_bastion" {
  description = "Public IPs of created bastion instances. "
  value       = module.aparavi-gce.public_ip_bastion
}
output "public_ip_collector" {
  description = "Public IPs of created collector instances. "
  value       = module.aparavi-gce.public_ip_collector
}

output "public_ip_aggregator" {
  description = "Public IPs of created aggregator instances. "
  value       = module.aparavi-gce.public_ip_aggregator
}
output "public_ip_monitoring" {
  description = "Public IPs of created monitoring instances. "
  value       = module.aparavi-gce.public_ip_monitoring
}
output "private_ip_cloudsql" {
  description = "CloudSQL private ip. "
  value       = module.aparavi-gce.private_ip_cloudsql
}
output "SSH_Connection_bastion" {
  value = module.aparavi-gce.SSH_Connection_bastion
}


#output "SSH_Connection_aggregator" {
#    value      = format("ssh connection to instance  ${var.instance_name_aggregator} ==> sudo ssh -i ~/id_rsa_gcp  ${var.admin}@%s",google_compute_instance.aparavi_instance_aggregator.network_interface.0.access_config.0.nat_ip)
#}


#  output "ip_collector" {
# value = google_compute_instance.aparavi_instance_collector.network_interface.0.access_config.0.nat_ip
#}

#output "ip_aggregator" {
# value = google_compute_instance.aparavi_instance_aggregator.network_interface.0.access_config.0.nat_ip
#}

#output "ip_bastion" {
# value = google_compute_instance.aparavi_instance_bastion.network_interface.0.access_config.0.nat_ip
#}
