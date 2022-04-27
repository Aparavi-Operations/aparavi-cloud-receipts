resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = local.vpc_name
  }
}

resource "aws_subnet" "vm_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.10.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = local.vpc_vm_subnet_name
  }
}

resource "aws_subnet" "db_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = local.vpc_db_subnet_name
  }
}