data "aws_ami" "aggregator_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["nonprod-aggregator-*"]
  }

  owners = ["814382576288"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.aggregator_ami.id
  instance_type = var.aggregator_instance_type

  tags = {
    Name = "AparaviAggregatorInstance"
  }
}