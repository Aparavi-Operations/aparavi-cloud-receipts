output "bastion_ip" {
  value = module.bastion.node_public_ip
}
output "node_ip" {
  value = module.node.node_public_ip
}
output "collector_ip" {
  value = var.appagent ? "none" : module.collector[0].node_public_ip
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
  value = var.appagent ? "none" : module.collector[0].node_private_ip
}
output "monitoring_private_ip" {
  value = module.monitoring.node_private_ip
}
output "monitoring_dashboard" {
  value = "http://${module.monitoring.node_public_ip}"
}
output "workers_ip" {
  value = ["${module.workers.*.node_private_ip}"]
}
output "workers_ip_1" {
  value = var.workers ? "${module.workers[0].node_private_ip}": "null"
}
output "workers_ip_2" {
  value = var.workers ? "${module.workers[1].node_private_ip}": "null"
}
output "workers_ip_3" {
  value = var.workers ? "${module.workers[2].node_private_ip}": "null"
}
output "rds_password" {
  value = module.node_db.rds_password
}
