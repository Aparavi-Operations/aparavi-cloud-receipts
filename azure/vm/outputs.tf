output "bastion_ip" {
  value = module.aparavi-azure-vm.bastion_ip
}
output "node_ip" {
  value = module.aparavi-azure-vm.node_ip
}
output "collector_ip" {
  value = module.aparavi-azure-vm.collector_ip
}
output "nodedb_endpoint" {
  value = module.aparavi-azure-vm.nodedb_endpoint
}
output "monitoring_ip" {
  value = module.aparavi-azure-vm.monitoring_ip
}
output "node_private_ip" {
  value = module.aparavi-azure-vm.node_private_ip
}
output "collector_private_ip" {
  value = module.aparavi-azure-vm.collector_private_ip
}
output "monitoring_private_ip" {
  value = module.aparavi-azure-vm.monitoring_private_ip
}
output "monitoring_dashboard" {
  value = module.aparavi-azure-vm.monitoring_dashboard
}
