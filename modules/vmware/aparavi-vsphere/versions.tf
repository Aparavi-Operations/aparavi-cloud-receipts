terraform {
  required_version = ">= 1.0.7"
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.2.0"
    }
  }
}
