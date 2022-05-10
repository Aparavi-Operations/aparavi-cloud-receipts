data "aws_availability_zones" "available" {}

module "network" {
  source          = "../../network"
  name            = "aparavi-example"
  cidr            = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  azs             = data.aws_availability_zones.available.names
}
