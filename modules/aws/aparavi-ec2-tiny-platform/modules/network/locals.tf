locals {
  vpc_name               = var.name
  vpc_public_subnet_name = "${var.name}-public"
  vpc_rds_subnet_name    = "${var.name}-rds"
}
