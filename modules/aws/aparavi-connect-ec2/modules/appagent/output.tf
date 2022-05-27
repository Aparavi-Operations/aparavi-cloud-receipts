data "aws_network_interface" "nic" {
  id = aws_instance.appagent_ec2.primary_network_interface_id
}

output "private_ip" {
  value = data.aws_network_interface.nic.private_ip
}

output "appagent_public_ip" {
  value = aws_instance.appagent_ec2.public_ip
}