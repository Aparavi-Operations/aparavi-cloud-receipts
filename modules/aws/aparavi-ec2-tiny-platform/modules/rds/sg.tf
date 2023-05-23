resource "aws_security_group" "rds" {
  name        = "${var.name}-rds"
  description = "${var.name} - Set of rules for RDS access"
  vpc_id      = var.vpc_id

  ingress {
    description = "TCP from VPC"
    from_port   = var.mysql_port
    to_port     = var.mysql_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
