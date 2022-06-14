output "appagent_private_ip" {
  value = module.appagent.private_ip
}
output "appagent_public_ip" {
  value = module.appagent.appagent_public_ip
}

output "grafana_url" {
  value       = module.monitoring.grafana_url
  description = "Grafana URL"
}
