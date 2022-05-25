data "aws_ami" "monitoring_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["nonprod-monitoring_instance-*"]
  }

  owners = ["814382576288"]
}

data "aws_region" "current" {}