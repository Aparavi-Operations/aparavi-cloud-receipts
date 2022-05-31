output "ssh_address" {
  value       = "admin@${aws_instance.monitoring_ec2.public_ip}"
  description = "SSH address to connecto to bastion instance"
}

output "grafana_url" {
  value       = "http://${aws_instance.monitoring_ec2.public_ip}"
  description = "Grafana URL"
}
