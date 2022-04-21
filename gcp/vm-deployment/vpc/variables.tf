# GCP Service account region and authentication 
# variable "prefix" {
#  description = "The prefix used for all resources in this example"
#}
variable  "gcp_credentials"{
  description = "default location of your service account json key file"
  default = "/home/lexa500/gcloud-auth-working.json"
}

variable "project" {
  default = "universal-team-347014"  #CHANGE ME
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
