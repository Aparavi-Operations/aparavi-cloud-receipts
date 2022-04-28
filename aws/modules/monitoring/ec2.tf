resource "aws_instance" "monitoring_ec2" {
  subnet_id              = var.vm_subnet_id
  ami                    = data.aws_ami.monitoring_ami.id
  instance_type          = local.monitoring_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2.id]

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = local.monitoring_ebs_size
    volume_type = "gp3"
  }

  user_data = <<EOF
#!/bin/bash
cd /root/monitoring
sed -i 's/<<deployment>>/test/g' vmagent/scrape.yml
docker-compose up -d
docker-compose restart vmagent
EOF

  iam_instance_profile = aws_iam_instance_profile.monitoring_profile.name

  metadata_options {
    http_endpoint = "enabled"
    http_put_response_hop_limit = 2
  }

  tags = {
    Name = "AparaviMonitoringInstance"
  }
}