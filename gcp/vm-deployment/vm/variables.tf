# GCP Service account region and authentication 
# variable "prefix" {
#  description = "The prefix used for all resources in this example"
#}
variable  "gcp_credentials"{
  description = "default location of your service account json key file"
  default = "~/gcp-key.json"
}

variable "project" {
  default = "playground-s-11-f538d00c"   # Change ME
}
variable "region" {
    default = "us-east1"
}

variable "zone" {
    default = "us-east1-b"
}
# VPC INFO
    variable "vnet_name" {
      default = "Terravpc"
    }
    
    variable "subnet-02_cidr" {
      default = "192.168.0.0/16"
    }

# SUBNET INFO
    variable "subnet_name"{
      default = "terrasub" 
      }

    variable "subnet_cidr"{
      default = "192.168.10.0/24"
      } 
  variable "firewall_name" {
    default = "aparavi_fw"
  }

 
variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  default     = ""
}

variable "instances_name" {
  description = "Number of instances to create. This value is ignored if static_ips is provided."
  default     = "terravm"
}

variable "admin" {
  description = "OS user"
  default  = "centos"
}

# VNIC INFO
        variable "private_ip" {
        default = "192.168.10.51"
      }
      
# BOOT INFO      
  # user data
variable "user_data" { 
  default = "./cloud-init/debian_userdata.txt"
  }     

 


variable "hostname" {
  description = "Hostname of instances"
  default     = "aparavi-app"
}
  

# COMPUTE INSTANCE INFO

      variable "instance_name" {
        default = "aparavi-app"
      }


      variable "osdisk_size" {
        default = "30"
      }
      variable "vm_type" {   # gcloud compute machine-types list --filter="zone:us-east1-b and name:e2-micro"
        default = "e2-micro" #"f1-micro"
      }
variable "OS" {     # gcloud compute images list --filter=name:ubuntu
  description = "the selected ami based OS"
  default       = "DEBIAN11" 
}

variable  "os_image" {
  default = {

    UBUNTU       =  {
          name = "ubuntu-os-cloud/ubuntu-2004-lts"
  
        }

       }
     }  

