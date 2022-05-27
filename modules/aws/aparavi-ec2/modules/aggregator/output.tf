data "aws_network_interface" "nic" {
  id = aws_instance.aggregator_ec2.primary_network_interface_id
}

output "private_ip" {
  value = data.aws_network_interface.nic.private_ip
}

output "ssh_address" {
  value = "admin@${aws_instance.aggregator_ec2.private_ip}"
}
