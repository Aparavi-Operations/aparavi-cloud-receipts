resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "${local.vpc_name} (${var.deployment_tag})"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_region.current.name}a"
  tags = {
    Name = "${local.vpc_public_subnet_name} (${var.deployment_tag})"
  }
}

resource "aws_subnet" "vm_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.10.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_region.current.name}a"

  tags = {
    Name = "${local.vpc_vm_subnet_name} (${var.deployment_tag})"
  }
}

resource "aws_subnet" "rds_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "${data.aws_region.current.name}a"

  tags = {
    Name = "${local.vpc_rds_subnet_name} (${var.deployment_tag})"
  }
}

resource "aws_subnet" "rds_subnet_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.10.4.0/24"
  availability_zone = "${data.aws_region.current.name}b"

  tags = {
    Name = "${local.vpc_rds_subnet_name} (${var.deployment_tag})"
  }
}

// public use only

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Aparavi Internet Gateway"
  }
}

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "Aparavi Elastic IP"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.allocation_id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "Aparavi NAT Gateway"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "vm_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Aparavi Private Subnet"
  }
}

resource "aws_route_table_association" "vm_rt_association" {
  subnet_id      = aws_subnet.vm_subnet.id
  route_table_id = aws_route_table.vm_rt.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Aparavi Public Subnet"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
