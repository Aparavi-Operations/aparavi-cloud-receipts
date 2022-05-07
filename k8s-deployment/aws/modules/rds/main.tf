resource "aws_db_instance" "this" {
  allocated_storage      = var.allocated_storage
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = var.instance_class
  identifier             = var.name
  db_name                = var.db_name
  username               = var.username
  password               = random_password.this.result
  db_subnet_group_name   = resource.aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]
  apply_immediately      = var.apply_immediately
  skip_final_snapshot    = var.skip_final_snapshot
  tags                   = var.tags
}

resource "random_password" "this" {
  length  = 16
  special = false
}

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
