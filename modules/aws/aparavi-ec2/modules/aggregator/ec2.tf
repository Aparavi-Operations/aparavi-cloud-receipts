resource "aws_instance" "aggregator_ec2" {
  subnet_id                   = var.vm_subnet_id
  associate_public_ip_address = false
  ami                         = data.aws_ami.aggregator_ami.id
  instance_type               = local.aggregator_instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.ec2.id]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = local.aggregator_ebs_size
  }

  user_data = <<EOF
#!/bin/bash
echo "aws ${aws_secretsmanager_secret.rds_secret.name} ${data.aws_region.current.name} ${aws_db_instance.aggregator_rds.address} ${local.mysql_port}" >> /opt/envvars
sed -i 's~ModuleArg=\"--moduleType=\$AppType\"~ModuleArg=\"--moduleType=\$AppType --config.node.parentObjectId=${var.parent_id}\"~g' /opt/aparavi-data-ia/aggregator/app/support/linux/startapp.sh
sed -i 's/%%PLATFORM%%/${var.platform}/g' /opt/aparavi-data-ia/aggregator/installerSettings.json
/opt/bootstrap.py
rm /opt/bootstrap.py /opt/envvars
/opt/aparavi-data-ia/aggregator/app/startapp
EOF

  iam_instance_profile = aws_iam_instance_profile.aggregator_profile.name

  tags = {
    Name                 = "Aparavi Aggregator Instance (${var.deployment_tag})"
    "aparavi:role"       = "aggregator"
    "aparavi:deployment" = "${var.deployment_tag}"
  }
}
