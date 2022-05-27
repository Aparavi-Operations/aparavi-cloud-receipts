output "vpc_name" {
  description = "The Name of the newly created vpc"
  value       = google_compute_network.aparavi-vpc.name
}
#output "vpc_id" {
#      description = "id of created vpc. "
#      value       = google_compute_network.aparavi_vpc.id
#    } 
    
output "Subnet_Name" {
      description = "Name of created vpc's Subnet. "
      value       =  google_compute_subnetwork.aparavi_sub.name
    }
output "Subnet_id" {
      description = "id of created vpc. "
      value       = google_compute_subnetwork.aparavi_sub.id
    }
output "Subnet_CIDR" {
      description = "cidr block of vpc's Subnet. "
      value       = google_compute_subnetwork.aparavi_sub.ip_cidr_range
    }         
    
##  INSTANCE OUTPUT
      output "instance_name_bastion" {
        description = " id of created bastion instance. "
        value       = google_compute_instance.aparavi_instance_bastion.name
      }
      output "instance_name_appagent" {
        description = " id of created aggregator-collector. "
        value       = google_compute_instance.aparavi_instance_appagent.name
      }
      output "instance_name_monitoring" {
        description = " id of created monitoring. "
        value       = google_compute_instance.aparavi_instance_monitoring.name
      }
      output "hostname_bastion" {
        description = " id of created bastion instances. "
        value       = google_compute_instance.aparavi_instance_bastion.hostname
      }
      output "hostname_appagent" {
        description = " id of created aggregator-collector instances. "
        value       = google_compute_instance.aparavi_instance_appagent.hostname
      }
      output "hostname_monitoring" {
        description = " id of created monitoring instances. "
        value       = google_compute_instance.aparavi_instance_monitoring.hostname
      }
      output "private_ip_bastion" {
        description = "Private IPs of created bastion instance. "
        value       = google_compute_instance.aparavi_instance_bastion.network_interface.0.network_ip
      }
      output "private_ip_appagent" {
        description = "Private IPs of created aggregator-collector instances. "
        value       = google_compute_instance.aparavi_instance_appagent.network_interface.0.network_ip
      }
      output "private_ip_monitoring" {
        description = "Private IPs of created monitoring instances. "
        value       = google_compute_instance.aparavi_instance_monitoring.network_interface.0.network_ip
      }
      output "public_ip_bastion" {
        description = "Public IPs of created bastion instances. "
        value       = google_compute_instance.aparavi_instance_bastion.network_interface.0.access_config.0.nat_ip
      }
      output "public_ip_appagent" {
        description = "Public IPs of created aggregator-collector instances. "
        value       = google_compute_instance.aparavi_instance_appagent.network_interface.0.access_config.0.nat_ip
      }
      output "public_ip_monitoring" {
        description = "Public IPs of created monitoring instances. "
        value       = google_compute_instance.aparavi_instance_monitoring.network_interface.0.access_config.0.nat_ip
      }
      output "private_ip_cloudsql" {
        description = "CloudSQL private ip. "
        value       = module.mysql.master_private_ip_address
      }
 output "SSH_Connection_bastion" {
     value      = format("ssh connection to instance  ${var.instance_name_bastion} ==> sudo ssh -i ~/.ssh/id_rsa_aparavi  ${var.admin}@%s",google_compute_instance.aparavi_instance_bastion.network_interface.0.access_config.0.nat_ip)
 }
    