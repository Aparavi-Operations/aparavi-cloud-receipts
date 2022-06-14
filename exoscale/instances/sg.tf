resource "exoscale_security_group" "sg" {
    name = "web-server"
}

resource "exoscale_security_group_rule" "http" {
    security_group_id = exoscale_security_group.sg.id
    type = "INGRESS"
    protocol = "tcp"
    cidr = "0.0.0.0/0"
    start_port = 80
    end_port = 80
}