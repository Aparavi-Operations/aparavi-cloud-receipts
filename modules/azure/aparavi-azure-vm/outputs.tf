output "bastion_ip" {
  value = module.bastion.node_public_ip
}
output "node_ip" {
  value = module.node.node_public_ip
}
output "collector_ip" {
  value = module.collector[0].node_public_ip
}
output "nodedb_endpoint" {
  value = module.node_db.endpoint
}
output "monitoring_ip" {
  value = module.monitoring.node_public_ip
}
output "node_private_ip" {
  value = module.node.node_private_ip
}
output "collector_private_ip" {
  value = module.collector[0].node_private_ip
}
output "monitoring_private_ip" {
  value = module.monitoring.node_private_ip
}
output "monitoring_dashboard" {
  value = "http://${module.monitoring.node_public_ip}"
}