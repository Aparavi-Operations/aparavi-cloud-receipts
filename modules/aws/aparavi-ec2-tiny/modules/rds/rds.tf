resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.name
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, {
    Name         = var.name
    subcomponent = var.subcomponent
  })
}

resource "aws_db_instance" "rds" {
  identifier             = var.name
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.id
  allocated_storage      = var.size
  port                   = var.mysql_port
  engine                 = "mysql"
  engine_version         = var.mysql_version
  instance_class         = var.mysql_instance_type
  username               = var.mysql_username
  password               = var.mysql_password
  multi_az               = var.multi_az
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds.id]

  tags = merge(var.tags, {
    Name         = var.name
    subcomponent = var.subcomponent
  })
}
