data "aws_ami" "this" {
  owners = ["136693071363"]
  filter {
    name   = "name"
    values = ["debian-10-amd64-*"]
  }
  name_regex  = "^debian-10-amd64-\\d{8}-\\d{3}"
  most_recent = true
}

resource "aws_security_group" "this" {
  name   = "allow-ssh"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.sg_cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami = data.aws_ami.this.id
  tags = {
    Name                 = "Aparavi Bastion Instance (${var.deployment_tag})"
    "aparavi:role"       = "bastion"
    "aparavi:deployment" = "${var.deployment_tag}"
  }
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]
  key_name               = var.key_name
  instance_type          = "t2.micro"
}
