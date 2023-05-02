resource "aws_db_instance" "rds" {
  identifier             = var.name
  db_subnet_group_name   = var.subnet_group
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
    component    = var.component
    subcomponent = "rds"
  })
}
