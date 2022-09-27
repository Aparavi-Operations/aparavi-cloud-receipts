variable "enabled" {
  type = bool
}

variable "name" {
  type = string
}

variable "resource_pool_id" {
  type = string
}

variable "datastore_id" {
  type = string
}

variable "network_id" {
  type = string
}

variable "template_uuid" {
  type = string
}

variable "user_data" {
  type = string
}

variable "num_cpus" {
  type = number
}

variable "memory" {
  type = number
}

variable "disk_size" {
  type = number
}

variable "guest_id" {
  type = string
}

output "ip_address" {
  value = try(vsphere_virtual_machine.this[0].default_ip_address, "")
}

resource "vsphere_virtual_machine" "this" {
  count = var.enabled ? 1 : 0

  name             = var.name
  resource_pool_id = var.resource_pool_id
  datastore_id     = var.datastore_id
  num_cpus         = var.num_cpus
  memory           = var.memory
  guest_id         = var.guest_id
  network_interface {
    network_id = var.network_id
  }
  disk {
    label = "disk0"
    size  = var.disk_size
  }
  clone {
    template_uuid = var.template_uuid
  }
  cdrom {
    client_device = true
  }
  vapp {
    properties = {
      user-data = var.user_data
    }
  }
}
