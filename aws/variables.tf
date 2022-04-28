variable "KEY_NAME" {
  description = "MANDATORY SSH Key name to attach to ec2 instances"
  default     = ""
  
  validation {
    condition     = length(var.KEY_NAME) > 0
    error_message = "You must add name of the SSH key to assign it to the EC2 instances."
  }
}

variable "MANAGEMENT_NETWORK" {
  description = "MANDATORY Management network to allow connections from (e.g. 0.0.0.0/0 for all incoming connection)"
  default     = ""
  
  validation {
    condition     = length(var.MANAGEMENT_NETWORK) > 0
    error_message = "You must specify the network cidr for security group ingress rule."
  }
}

variable "PLATFORM" {
  description = "MANDATORY Platform to attach aggregator to (e.g. preview.aparavi.com)"
  default     = ""

  validation {
    condition     = length(var.PLATFORM) > 0
    error_message = "You must specify the host for platform so aggregator could connect to it. (e.g. preview.aparavi.com)"
  }
}

variable "PARENT_ID" {
  description = "ID from Aparavi Portal"
  default     = ""

  validation {
    condition     = length(var.PARENT_ID) > 0
    error_message = "You must specify the parent_id from th platform in order to place there the new aggregator instance."
  }
}

variable "DEPLOYMENT" {
  description = "MANDATORY Unique name of the deployment. Multiple deployments of this stack in single VPC are supported (e.g. attempt1)"
  default     = ""
  
  validation {
    condition     = length(var.DEPLOYMENT) > 0
    error_message = "You must specify the deployment tag in order to separate deployments."
  }
}