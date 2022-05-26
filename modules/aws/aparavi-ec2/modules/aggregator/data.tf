data "aws_ami" "aggregator_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["nonprod-aggregator-*"]
  }

  owners = ["814382576288"]
}

data "aws_secretsmanager_secret" "rds_secret" {
  arn = aws_secretsmanager_secret.rds_secret.arn
}

data "aws_secretsmanager_secret_version" "rds_creds" {
  secret_id = data.aws_secretsmanager_secret.rds_secret.arn
}

data "aws_region" "current" {}