# GCP Service account region and authentication 
# variable "prefix" {
#  description = "The prefix used for all resources in this example"
#}
variable  "gcp_credentials"{
  description = "default location of your service account json key file"
  default = "~/gcp-key.json"
}

variable "project" {
  default = "playground-s-11-83a5e4fc"
}
variable "region" {
    default = "us-east1"
}

variable "zone" {
    default = "us-east1-b"
}
# VPC INFO
variable "vnet_name" {
      default = "aparavi-vpc"
    }
    
variable "subnet-02_cidr" {
      default = "10.105.0.0/16"
    }

# SUBNET INFO
    variable "subnet_name"{
      default = "aparavi-subnet" 
      }

    variable "subnet_cidr"{
      default = "10.105.10.0/24"
      } 
  variable "firewall_name" {
    default = "aparavi_fw"
  }
