resource "aws_security_group" "ec2" {
  name        = var.name
  description = "${var.name} - set of rules for EC2 access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow ssh access from the management network"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
