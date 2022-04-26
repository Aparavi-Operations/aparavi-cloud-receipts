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

output "fire_wall_rules" {
      description = "Shows ingress rules of the Security group "
     value       = google_compute_firewall.aparavi-app-aggregator.allow
}         
    
##  INSTANCE OUTPUT

      output "instance_name_collector" {
        description = " id of created collector instances. "
        value       = google_compute_instance.aparavi_instance_collector.name
      }

      output "instance_name_aggregator" {
        description = " id of created collector aggregator. "
        value       = google_compute_instance.aparavi_instance_aggregator.name
      }
      output "hostname_collector" {
        description = " id of created collector instances. "
        value       = google_compute_instance.aparavi_instance_collector.hostname
      }
      output "hostname_aggregator" {
        description = " id of created aggregator instances. "
        value       = google_compute_instance.aparavi_instance_aggregator.hostname
      }
      
      output "private_ip_collector" {
        description = "Private IPs of created collector instances. "
        value       = google_compute_instance.aparavi_instance_collector.network_interface.0.network_ip
      }
      output "private_ip_aggregator" {
        description = "Private IPs of created aggregator instances. "
        value       = google_compute_instance.aparavi_instance_aggregator.network_interface.0.network_ip
      }
      
      output "public_ip_collector" {
        description = "Public IPs of created collector instances. "
        value       = google_compute_instance.aparavi_instance_collector.network_interface.0.access_config.0.nat_ip
      }

      output "public_ip_aggregator" {
        description = "Public IPs of created aggregator instances. "
        value       = google_compute_instance.aparavi_instance_aggregator.network_interface.0.access_config.0.nat_ip
      }
 #output "SSH_Connection_collector" {
 #    value      = format("ssh connection to instance  ${var.instance_name_collector} ==> sudo ssh -i ~/id_rsa_gcp  ${var.admin}@%s",google_compute_instance.aparavi_instance_collector.network_interface.0.access_config.0.nat_ip)
#}

 #output "SSH_Connection_aggregator" {
 #    value      = format("ssh connection to instance  ${var.instance_name_aggregator} ==> sudo ssh -i ~/id_rsa_gcp  ${var.admin}@%s",google_compute_instance.aparavi_instance_aggregator.network_interface.0.access_config.0.nat_ip)
#}

  
  
    