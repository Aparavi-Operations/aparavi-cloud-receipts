resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = merge(var.tags, {
    Name = local.vpc_name
  })
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 0)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = merge(var.tags, {
    Name = local.vpc_public_subnet_name
  })
}

resource "aws_subnet" "rds_subnets" {
  for_each          = { for i, v in data.aws_availability_zones.available.names : i => v }
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 8 + each.key)
  availability_zone = each.value

  tags = merge(var.tags, {
    Name = "${local.vpc_rds_subnet_name}-${each.key}"
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(var.tags, {
    Name = local.vpc_name
  })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(var.tags, {
    Name = local.vpc_public_subnet_name
  })
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
