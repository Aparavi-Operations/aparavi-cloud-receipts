output "ssh_address" {
  value       = "admin@${aws_instance.this.public_ip}"
  description = "SSH address to connecto to bastion instance"
}
