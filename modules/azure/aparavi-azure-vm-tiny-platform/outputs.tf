output "platfrom_node_ip" {
  value = module.node.node_public_ip
}
output "nodedb_endpoint" {
  value = module.node.db_endpoint
}
output "node_private_ip" {
  value = module.node.node_private_ip
}
