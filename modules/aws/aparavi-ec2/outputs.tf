output "bastion_ssh_address" {
  value       = module.bastion.ssh_address
  description = "SSH address to connect to bastion instance"
}

output "aggregator_ssh_address" {
  value       = module.aggregator.ssh_address
  description = "SSH address to connect to aggregator instance"
}

output "collector_ssh_addresses" {
  value       = module.collector.ssh_addresses
  description = "List of SSH addresses to connect to collector instances"
}

output "monitoring_ssh_address" {
  value       = module.monitoring.ssh_address
  description = "SSH address to connecto to monitoring instance"
}
