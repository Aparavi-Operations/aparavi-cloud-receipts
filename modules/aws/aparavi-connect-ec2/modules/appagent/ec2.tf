module "cloudinit_config" {
  source             = "./cloudinit-config"
  platform_bind_addr = var.platform
  db_addr            = aws_db_instance.appagent_rds.address
  db_user            = local.mysql_username
  db_passwd          = random_password.password.result
  parentid           = var.parent_id
}
resource "aws_instance" "appagent_ec2" {
  subnet_id              = var.vm_subnet_id
  ami                    = data.aws_ami.appagent_ami.id
  instance_type          = local.appagent_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = local.appagent_ebs_size
  }
  user_data_base64     = module.cloudinit_config.rendered_config
  iam_instance_profile = aws_iam_instance_profile.appagent_profile.name
  tags = {
    Name                 = "Aparavi AppAgent Instance (${var.deployment_tag})"
    "aparavi:role"       = "appagent"
    "aparavi:deployment" = "${var.deployment_tag}"
  }
}
