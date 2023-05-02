data "aws_eip" "eip" {
  count     = var.elastic_ip != "" ? 1 : 0
  public_ip = var.elastic_ip
}

resource "aws_eip_association" "eip_assoc" {
  count         = var.elastic_ip != "" ? 1 : 0
  instance_id   = aws_instance.host.id
  allocation_id = join("", data.aws_eip.eip[*].id)
}

resource "aws_instance" "host" {
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip
  ami                         = data.aws_ami.host_ami.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.ec2.id]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = var.root_size
  }

  user_data = <<EOF
## template: jinja
#!/bin/bash
HOSTNAME="${var.name}-$(echo "{{ ds.meta_data.local_ipv4 }}" | sed s/[.]/-/g)"
sed -i "s/^127.0.1.1 .* .*$/127.0.0.1 $${HOSTNAME}/" /etc/hosts
hostnamectl set-hostname $HOSTNAME
curl -L -o /root/${var.init_repo}-${var.init_repo_branch}.zip https://github.com/${var.init_repo_org}/${var.init_repo}/archive/${var.init_repo_branch}.zip
apt update && apt install -y unzip
unzip /root/${var.init_repo}-${var.init_repo_branch}.zip -d /root
/root/${var.init_repo}-${var.init_repo_branch}/${var.init_script} ${var.init_options}
EOF

  tags = merge(var.tags, {
    Name         = var.name
    component    = var.component
    subcomponent = "app"
  })
}
