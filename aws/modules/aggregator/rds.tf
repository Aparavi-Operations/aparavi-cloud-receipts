resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  port                 = local.mysql_port
  engine               = "mysql"
  engine_version       = "8.0.26"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "aparavi"
  password             = "foobarbaz"
  publicly_accessible = false
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds.id]
}