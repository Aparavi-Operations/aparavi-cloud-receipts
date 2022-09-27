terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.2.0"
    }
  }
}

provider "vsphere" {
  user                 = var.user
  password             = var.password
  vsphere_server       = var.server
  allow_unverified_ssl = true
}
