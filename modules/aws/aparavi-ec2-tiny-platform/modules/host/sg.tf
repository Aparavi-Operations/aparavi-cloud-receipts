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
      "3.223.232.7/32",
    ]
  }
  ingress {
    description = "Allow node exporter access from the management network"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = [
      "3.223.232.7/32",
    ]
  }
  ingress {
    description = "Allow ssh inbound access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Platform http inbound access"
    from_port   = 9452
    to_port     = 9452
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Platform data inbound access"
    from_port   = 9455
    to_port     = 9455
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
