resource "aws_instance" "collector_ec2" {
  subnet_id              = var.vm_subnet_id
  ami                    = data.aws_ami.collector_ami.id
  instance_type          = local.collector_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2.id]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = local.collector_ebs_size
  }

  user_data = <<EOF
#!/bin/bash
sleep 120
echo "${var.aggregator_hostname}" >> /opt/envvars 
/opt/bootstrap.py
rm /opt/bootstrap.py /opt/envvars  
/opt/aparavi-data-ia/aggregator/app/startapp
EOF

  tags = {
    Name = "AparaviCollectorInstance"
    "aparavi:role" = "aggregator"
    "aparavi:deployment" = "test"
  }
}