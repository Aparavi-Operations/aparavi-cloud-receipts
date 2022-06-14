output "appagent_private_ip" {
  value = module.aparavi-connect-ec2.appagent_private_ip
}
output "appagent_public_ip" {
  value = module.aparavi-connect-ec2.appagent_public_ip
}

output "grafana_url" {
  value       = module.aparavi-connect-ec2.grafana_url
  description = "Grafana URL"
}
