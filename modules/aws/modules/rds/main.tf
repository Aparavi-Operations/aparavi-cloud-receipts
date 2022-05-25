resource "aws_db_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    { "Name" = var.name },
  )
}

resource "aws_security_group" "allow_mysql" {
  name        = "allow-mysql"
  description = "Allow MySQL inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "MySQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.sg_cidr_blocks
  }

  tags = merge(
    var.tags,
    { "Name" = "allow-mysql" },
  )
}

resource "random_password" "this" {
  length  = 32
  special = false # APARAVI Data IA Installer misbehaves on some of these.
}

resource "aws_db_instance" "this" {
  identifier             = var.name
  tags                   = var.tags
  engine                 = "mysql"
  engine_version         = "8.0.28"
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  instance_class         = var.instance_class
  username               = "aggregator"
  password               = random_password.this.result
  db_subnet_group_name   = resource.aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]
  apply_immediately      = true
  skip_final_snapshot    = true
}
