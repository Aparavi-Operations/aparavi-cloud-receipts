resource "random_password" "password" {
  length           = 16
  special          = false
  override_special = "_%@"
}

resource "random_string" "secret_suffix" {
  length           = 5
  special          = false
  override_special = "_%@"
}
 
resource "aws_secretsmanager_secret" "rds_secret" {
   name = "RDS_Credentials_${random_string.secret_suffix.result}_${var.deployment_tag}"
}
 
resource "aws_secretsmanager_secret_version" "rds_creds" {
  secret_id = aws_secretsmanager_secret.rds_secret.id
  secret_string = <<EOF
   {
    "username": "${local.mysql_username}",
    "password": "${random_password.password.result}"
   }
EOF
}