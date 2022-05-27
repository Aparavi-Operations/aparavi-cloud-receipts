output "ssh_addresses" {
  value = formatlist(
    "admin@%s",
    aws_instance.collector_ec2[*].private_ip
  )
  description = "List of SSH addresses to connect to collector instances"
}
