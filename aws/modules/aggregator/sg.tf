resource "aws_security_group" "aggregator" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.network_vpc_id

  ingress {
    description      = "Allow ssh access from the management network"
    from_port        = 0
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow http access from the management network"
    from_port        = 0
    to_port          = local.aggregator_http_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow aparavi datanet traffic from the management network"
    from_port        = 0
    to_port          = local.aggregator_data_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow aparavi datanet traffic from the management network"
    from_port        = 0
    to_port          = local.agent_data_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  /*tags = {
    Name = "allow_tls"
  }*/
}

resource "aws_security_group" "rds" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.network_vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = local.mysql_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}