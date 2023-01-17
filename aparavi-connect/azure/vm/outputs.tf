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
output "workers_ip" {
  value = module.aparavi-azure-vm.workers_ip
}
output "ssh_config" {
  value = <<SSHCONFIG
  ### START Auto-gen SSH Config for ${var.name} appliance ###
  Host ${var.name}-bastion
    User          aparavi
    Hostname      ${module.aparavi-azure-vm.bastion_ip}
    IdentityFile ~/.ssh/id_rsa
  Host ${var.name}-node
    User          aparavi
    Hostname      ${module.aparavi-azure-vm.node_private_ip}
    ProxyCommand  ssh ${var.name}-bastion -W %h:%p
    IdentityFile ~/.ssh/id_rsa
  Host ${var.name}-monitoring
    User          aparavi
    Hostname      ${module.aparavi-azure-vm.monitoring_private_ip}
    ProxyCommand  ssh ${var.name}-bastion -W %h:%p
    IdentityFile ~/.ssh/id_rsa

  Host ${var.name}-worker1
    User          aparavi
    Hostname      ${module.aparavi-azure-vm.workers_ip_1}
    ProxyCommand  ssh ${var.name}-bastion -W %h:%p
    IdentityFile ~/.ssh/id_rsa
  Host ${var.name}-worker2
    User          aparavi
    Hostname      ${module.aparavi-azure-vm.workers_ip_1}
    ProxyCommand  ssh ${var.name}-bastion -W %h:%p
    IdentityFile ~/.ssh/id_rsa
  Host ${var.name}-worker3
    User          aparavi
    Hostname      ${module.aparavi-azure-vm.workers_ip_1}
    ProxyCommand  ssh ${var.name}-bastion -W %h:%p
    IdentityFile ~/.ssh/id_rsa
  ### END Auto-gen SSH Config for ${var.name} appliance ###
    SSHCONFIG
}