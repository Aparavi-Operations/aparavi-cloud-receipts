data "aws_availability_zones" "available" {
  count = length(var.azs) > 0 ? 0 : 1
}

locals {
  public_subnet_suffix  = "public"
  private_subnet_suffix = "private"
  azs = (
    length(var.azs) > 0 ?
    var.azs :
    data.aws_availability_zones.available[0].names
  )
}

resource "aws_vpc" "this" {
  cidr_block = var.cidr

  tags = merge({ "Name" = var.name }, var.tags)
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge({ "Name" = var.name }, var.tags)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    { "Name" = "${var.name}-${local.public_subnet_suffix}" },
    var.tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    { "Name" = "${var.name}-${local.private_subnet_suffix}" },
    var.tags,
  )
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(local.azs, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name" = format(
        "${var.name}-${local.public_subnet_suffix}-%s",
        element(local.azs, count.index),
      )
    },
    var.tags,
  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(local.azs, count.index)

  tags = merge(
    {
      "Name" = format(
        "${var.name}-${local.private_subnet_suffix}-%s",
        element(local.azs, count.index),
      )
    },
    var.tags,
  )
}

resource "aws_eip" "nat" {
  vpc = true

  tags = merge({ "Name" = var.name }, var.tags)
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.allocation_id
  subnet_id     = aws_subnet.public[0].id

  tags = merge({ "Name" = var.name }, var.tags)

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
