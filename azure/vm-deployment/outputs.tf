output "bastion_ip" {
  value = module.bastion.node_public_ip
}
output "aggregator_ip" {
  value = module.aggregator.node_public_ip
}
output "collector_ip" {
  value = module.collector.node_public_ip
}
output "aggregatordb_endpoint" {
  value = module.aggregator_db.endpoint
}
output "monitoring_ip" {
  value = module.monitoring.node_public_ip
}
output "aggregator_private_ip" {
  value = module.aggregator.node_private_ip
}
output "collector_private_ip" {
  value = module.collector.node_private_ip
}
output "monitoring_private_ip" {
  value = module.monitoring.node_private_ip
}
output "monitoring_dashboard" {
  value = "http://${module.monitoring.node_public_ip}"
}