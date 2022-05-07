module "rds" {
  source              = "../../rds"
  apply_immediately   = true
  skip_final_snapshot = true
  name                = "aparavi-example"
  instance_class      = "db.t4g.micro"
  allocated_storage   = 100
  username            = "aggregator"
  db_name             = "aggregator"
  subnet_ids          = var.subnet_ids
  vpc_id              = var.vpc_id
  sg_cidr_blocks      = var.sg_cidr_blocks
}
