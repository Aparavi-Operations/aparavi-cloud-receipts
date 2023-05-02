resource "aws_security_group" "ec2" {
  name        = var.name
  description = "${var.name} - set of rules for EC2 access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow mysqld exporter access from the management network"
    from_port   = 9104
    to_port     = 9104
    protocol    = "tcp"
    cidr_blocks = [
      "52.54.1.79/32",
      "34.231.218.142/32",
      "52.54.237.132/32"
    ]
  }
  ingress {
    description = "Allow node exporter access from the management network"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = [
      "52.54.1.79/32",
      "34.231.218.142/32",
      "52.54.237.132/32"
    ]
  }
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
