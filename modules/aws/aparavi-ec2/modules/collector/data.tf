data "aws_ami" "collector_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["nonprod-collector-*"]
  }

  owners = ["814382576288"]
}

data "aws_region" "current" {}