output "connect_ip" {
  value = var.elastic_ip != "" ? var.elastic_ip : (var.associate_public_ip ? aws_instance.host.public_ip : aws_instance.host.private_ip)
}
