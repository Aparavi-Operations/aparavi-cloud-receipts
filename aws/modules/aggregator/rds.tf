resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "aggregator_rds_subnet_group_${var.deployment_tag}"
  subnet_ids = [var.rds_subnet_id_a,var.rds_subnet_id_b]

  tags = {
    Name = "Aggregator_RDS_Subnet_group_${var.deployment_tag}"
  }
}

resource "aws_db_instance" "aggregator_rds" {
  name                 = "AparaviAggregatorDB_${var.deployment_tag}"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.id
  allocated_storage    = 20
  port                 = local.mysql_port
  engine               = "mysql"
  engine_version       = "8.0.26"
  instance_class       = local.mysql_instance_type
  username             = local.mysql_username
  password             = local.rds_creds.password
  multi_az             = false
  publicly_accessible  = false
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds.id]

  tags = {
    Name = "Aggregator_RDS_Instance_${var.deployment_tag}"
  }
}