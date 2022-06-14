resource "exoscale_security_group" "sg-appagent" {
    name = "sg-appagent"
}

resource "exoscale_security_group" "sg-monitoring" {
    name = "sg-monitoring"
}

resource "exoscale_security_group_rule" "appagent-ssh" {
    security_group_id = exoscale_security_group.sg-monitoring.id
    type = "INGRESS"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    start_port = 22
    end_port = 22
}

resource "exoscale_security_group_rule" "appagent-exporter" {
    security_group_id = exoscale_security_group.sg-appagent.id
    type = "INGRESS"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    start_port = 9100
    end_port = 9100
}

resource "exoscale_security_group_rule" "monitoring-ssh" {
    security_group_id = exoscale_security_group.sg-monitoring.id
    type = "INGRESS"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    start_port = 22
    end_port = 22
}

resource "exoscale_security_group_rule" "monitoring-http" {
    security_group_id = exoscale_security_group.sg-monitoring.id
    type = "INGRESS"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    start_port = 80
    end_port = 80
}