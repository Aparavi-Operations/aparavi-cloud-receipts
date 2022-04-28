# EC2 Settings
variable "KEY_NAME" {
  description = "MANDATORY SSH Key name to attach to ec2 instances"
  default     = "gkudinov"
  
  validation {
    condition     = length(var.KEY_NAME) > 0
    error_message = "You must add name of the SSH key to assign it to the EC2 instances."
  }
}

# Network and security
variable "MANAGEMENT_NETWORK" {
  description = "MANDATORY Management network to allow connections from"
  default     = "0.0.0.0/0"
  
  validation {
    condition     = length(var.MANAGEMENT_NETWORK) > 0
    error_message = "You must specify the network cidr for security group ingress rule."
  }
}

variable "PLATFORM" {
  description = "MANDATORY Platform to attach aggregator to"
  default     = "preview.aparavi.com"

  validation {
    condition     = length(var.PLATFORM) > 0
    error_message = "You must specify the host for platform so aggregator could connect to it."
  }
}

variable "PARENT_ID" {
  description = "ID from Aparavi Portal"
  default     = "bbbbbbbb-bbbb-bbbb-bbbb-brdimitrenko"

  validation {
    condition     = length(var.PARENT_ID) > 0
    error_message = "You must specify the parent_id from th platform in order to place there the new aggregator instance."
  }
}

# Other settings
variable "DEPLOYMENT" {
  description = "Unique name of the deployment. Multiple deployments of this stack in single VPC are supported"
  default     = "test"
}