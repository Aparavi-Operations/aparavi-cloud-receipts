output "appagent_private_ip" {
  value = module.appagent.private_ip
}
output "monitoring_private_ip" {
  value = module.monitoring.private_ip
}
output "monitoring_public_ip" {
  value = module.monitoring.monitoring_public_ip
}