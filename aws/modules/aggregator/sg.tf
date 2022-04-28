resource "aws_security_group" "ec2" {
  name        = "Aggregator_EC2_SG"
  description = "Set of rules for EC2 access"
  vpc_id      = var.network_vpc_id

  ingress {
    description      = "Allow ssh access from the management network"
    from_port        = local.ssh_port
    to_port          = local.ssh_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow http access from the management network"
    from_port        = local.aggregator_http_port
    to_port          = local.aggregator_http_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow aparavi datanet traffic from the management network"
    from_port        = local.aggregator_data_port
    to_port          = local.aggregator_data_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow aparavi datanet traffic from the management network"
    from_port        = local.agent_data_port
    to_port          = local.agent_data_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow Node Exporter scraping from the monitoring instance"
    from_port        = local.node_exporter_port
    to_port          = local.node_exporter_port
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
  name        = "RDS_SG"
  description = "Set of rules for RDS access"
  vpc_id      = var.network_vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = local.mysql_port
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

  /*tags = {
    Name = "allow_tls"
  }*/
}