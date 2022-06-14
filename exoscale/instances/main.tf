data "exoscale_compute_template" "ubuntu" {
    zone = "de-fra-1"
    name = "Linux Ubuntu 20.04 LTS 64-bit"
}
data "template_file" "cloudinit" {
  template = file("init.tpl")

  vars = {
    eip = exoscale_ipaddress.ingress.ip_address
  }
}
resource "exoscale_compute" "web-sv1" {
    display_name               = "web-sv1"
    zone = "de-fra-1"
    #display_name = "test"
    template_id = data.exoscale_compute_template.ubuntu.id
    #type               = "standard.medium"
    size = "Tiny"
    disk_size = 50
    #elastic_ip_ids = [exoscale_elastic_ip.aparavi-1.id]
    #public_ip_address = exoscale_elastic_ip.aparavi-1.id
    key_pair = exoscale_ssh_keypair.instance-key.id
    security_group_ids = [ exoscale_security_group.sg.id, ]
    user_data = data.template_file.cloudinit.rendered
    timeouts {
        create = "1m"
        read   = "2m"
        update = "3m"
        delete = "4m"
    }

    #network_interface {
    #    network_id = exoscale_private_network.aparavi-managed.id
    #    ip_address = "10.0.0.20"
    #}
    tags = {
        managedby = "terraform"
        app = "aparavi"
    }
}