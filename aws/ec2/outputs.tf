output "bastion_ssh_address" {
  value       = module.aparavi-ec2.bastion_ssh_address
  description = "SSH address to connect to bastion instance"
}

output "aggregator_ssh_address" {
  value       = module.aparavi-ec2.aggregator_ssh_address
  description = "SSH address to connect to aggregator instance"
}

output "collector_ssh_addresses" {
  value       = module.aparavi-ec2.collector_ssh_addresses
  description = "List of SSH addresses to connect to collector instances"
}

output "monitoring_ssh_address" {
  value       = module.aparavi-ec2.monitoring_ssh_address
  description = "SSH address to connect to monitoring instance"
}
