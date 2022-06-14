resource "exoscale_private_network" "aparavi-managed" {
  zone        = "de-fra-1"
  name        = "aparavi"
  description = "Out-of-band network with DHCP"
  start_ip    = "10.0.0.20"
  end_ip      = "10.0.0.253"
  netmask     = "255.255.255.0"
}

#resource "exoscale_elastic_ip" "aparavi-1" {
#  zone = "de-fra-1"
#}

resource "exoscale_ipaddress" "ingress" {
  zone = "de-fra-1"
  description = "my elastic IP"
}