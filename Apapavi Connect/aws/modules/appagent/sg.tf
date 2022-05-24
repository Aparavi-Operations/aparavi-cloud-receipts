resource "aws_security_group" "ec2" {
  name        = "appagent_EC2_SG_${var.deployment_tag}"
  description = "Set of rules for EC2 access (${var.deployment_tag})"
  vpc_id      = var.network_vpc_id

  ingress {
    description      = "Allow ssh access from the management network"
    from_port        = local.ssh_port
    to_port          = local.ssh_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow ssh access from the Internet"
    from_port        = local.ssh_port
    to_port          = local.ssh_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow http access from the management network"
    from_port        = local.appagent_http_port
    to_port          = local.appagent_http_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow aparavi datanet traffic from the management network"
    from_port        = local.appagent_data_port
    to_port          = local.appagent_data_port
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
}

resource "aws_security_group" "rds" {
  name        = "RDS_SG_${var.deployment_tag}"
  description = "Set of rules for RDS access (${var.deployment_tag})"
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
}