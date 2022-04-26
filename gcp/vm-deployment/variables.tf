# GCP Service account region and authentication 
# variable "prefix" {
#  description = "The prefix used for all resources in this example"
#}


variable "project" {
  default = "universal-team-347014"   # Change ME
}
variable "region" {
    default = "us-east1"
}

variable "parentid" {
    #default = "bbbbbbbb-bbbb-bbbb-bbbb-brdimitrenko"
}
variable "bind_addr"{ #DNS name of the platform without https:// part
   #default = "aaa.bbb.com" #DNS name of the platform without https:// part
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
      default = "aparavi-sub" 
      }

    variable "subnet_cidr"{
      default = "10.105.10.0/24"
      }
  variable "firewall_name" {
    default = "aparavi_fw"
  }

 
variable "subnetwork_project" {
  description = "The project that subnetwork belongs to"
  default     = ""
}

variable "instances_name_collector" {
  
  default     = "aparavi-app-collector-test-dpl"
}

variable "instances_name_aggregator" {
  
  default     = "aparavi-app-aggregator-test-dpl"
}
variable "instance_name_bastion" {
  default     = "aparavi-bastion-test-dpl"
}
variable "admin" {
  description = "OS user"
  default  = "admin"
}

# VNIC INFO
      variable "private_ip_aggregator" {
        default = "10.105.10.51"
      }
      variable "private_ip_collector" {
        default = "10.105.10.52"
      }
      variable "private_ip_bastion" {
        default = "10.105.10.53"
      }
# BOOT INFO      
  # user data
variable "user_data_collector" { 
  default = "./cloud-init/debian_userdata_collector.sh"
  }     

variable "user_data_aggregator" { 
  default = "./cloud-init/debian_userdata_aggregator.sh"
  }     



variable "hostname_collector" {
  description = "Hostname ofcollector instances"
  default     = "aparavi-app-collector-test-dpl.org.info"
}

variable "hostname_aggregator" {
  description = "Hostname of aggregator instances"
  default     = "aparavi-app-aggregator-test-dpl.org.info"
}

variable "hostname_bastion" {
  description = "Hostname of bastion instance"
  default     = "aparavi-bastion-test-dpl.org.info"
}

# COMPUTE INSTANCE INFO

      variable "instance_name" {
        default = "aparavi-app"
      }


      variable "osdisk_size" {
        default = "30"
      }
      variable "vm_type" {   # gcloud compute machine-types list --filter="zone:us-east1-b and name:e2-micro"
        default = "n2-standard-2" #"f1-micro"
      }

# Note, after a name db instance is used, it cannot be reused for up to one week.
variable "name_prefix" {
  description = "The name prefix for the database instance. Will be appended with a random string. Use lowercase letters, numbers, and hyphens. Start with a letter."
  type        = string
  default = "aparavi"
}

variable "master_user_name" {
  description = "The username part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_name so you don't check it into source control."
  type        = string
}

variable "master_user_password" {
  description = "The password part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_password so you don't check it into source control."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "mysql_version" {
  description = "The engine version of the database, e.g. `MYSQL_5_6` or `MYSQL_5_7`. See https://cloud.google.com/sql/docs/features for supported versions."
  type        = string
  default     = "MYSQL_8_0"
}

variable "machine_type" {
  description = "The machine type to use, see https://cloud.google.com/sql/pricing for more details"
  type        = string
  default     = "db-f1-micro"
}

variable "db_name" {
  description = "Name for the db"
  type        = string
  default     = "default"
}

variable "name_override" {
  description = "You may optionally override the name_prefix + random string by specifying an override"
  type        = string
  default     = null
}
