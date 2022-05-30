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

output "instance_name_appagent" {
  description = " id of created appagent. "
  value       = module.aparavi-gce.instance_name_appagent
}
output "instance_name_monitoring" {
  description = " id of created appagent. "
  value       = module.aparavi-gce.instance_name_monitoring
}
output "hostname_bastion" {
  description = " id of created bastion instances. "
  value       = module.aparavi-gce.hostname_bastion
}
output "hostname_appagent" {
  description = " id of created appagent instances. "
  value       = module.aparavi-gce.hostname_appagent
}
output "hostname_monitoring" {
  description = " id of created monitoring instances. "
  value       = module.aparavi-gce.hostname_monitoring
}
output "private_ip_bastion" {
  description = "Private IPs of created bastion instance. "
  value       = module.aparavi-gce.private_ip_bastion
}
output "private_ip_appagent" {
  description = "Private IPs of created appagent instances. "
  value       = module.aparavi-gce.private_ip_appagent
}
output "private_ip_monitoring" {
  description = "Private IPs of created monitoring instances. "
  value       = module.aparavi-gce.private_ip_monitoring
}
output "public_ip_bastion" {
  description = "Public IPs of created bastion instances. "
  value       = module.aparavi-gce.public_ip_bastion
}
output "public_ip_appagent" {
  description = "Public IPs of created appagent instances. "
  value       = module.aparavi-gce.public_ip_appagent
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
output "monitoring_dashboard" {
  value = module.aparavi-gce.monitoring_dashboard
}
