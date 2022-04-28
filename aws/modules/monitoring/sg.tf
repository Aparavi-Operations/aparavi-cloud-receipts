resource "aws_security_group" "ec2" {
  name        = "Monitoring_EC2_SG"
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
    description      = "Allow access to Grafana from the management network"
    from_port        = local.grafana_port
    to_port          = local.grafana_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow access to VMagent http console from the management network"
    from_port        = local.vmagent_http_port
    to_port          = local.vmagent_http_port
    protocol         = "tcp"
    cidr_blocks      = ["${var.management_network}"]
  }

  ingress {
    description      = "Allow access to VMinsert http console from the management network"
    from_port        = local.vminsert_http_port
    to_port          = local.vminsert_http_port
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