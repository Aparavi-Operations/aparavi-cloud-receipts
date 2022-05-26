data "aws_ami" "appagent_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }

  owners = ["136693071363"]
}

data "aws_secretsmanager_secret" "rds_secret" {
  arn = aws_secretsmanager_secret.rds_secret.arn
}

data "aws_secretsmanager_secret_version" "rds_creds" {
  secret_id = data.aws_secretsmanager_secret.rds_secret.arn
}

data "aws_region" "current" {}