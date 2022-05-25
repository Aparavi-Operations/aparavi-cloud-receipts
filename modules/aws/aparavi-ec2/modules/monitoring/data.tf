data "aws_ami" "monitoring_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["nonprod-monitoring_instance-2022-Mar-31 06-57"]
  }

  owners = ["814382576288"]
}

data "aws_region" "current" {}