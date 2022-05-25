variable "KEY_NAME" {
  description = "MANDATORY - SSH Key name to attach to ec2 instances"
  default     = ""
  
  validation {
    condition     = length(var.KEY_NAME) > 0
    error_message = "You must add name of the SSH key to assign it to the EC2 instances."
  }
}

variable "MANAGEMENT_NETWORK" {
  description = "MANDATORY - Allow connections from Management network (e.g. 0.0.0.0/0 for all incoming connection from the Internet)"
  default     = ""
  
  validation {
    condition     = length(var.MANAGEMENT_NETWORK) > 0
    error_message = "You must specify the network CIDR for security group ingress rule."
  }
}

variable "PLATFORM" {
  description = "MANDATORY - Platform to attach an aggregator to (e.g. preview.aparavi.com)"
  default     = ""

  validation {
    condition     = length(var.PLATFORM) > 0
    error_message = "You must specify the host for the platform so aggregator could connect to it. (e.g. preview.aparavi.com)."
  }
}

variable "PARENT_ID" {
  description = "MANDATORY - activeNodeId from Aparavi Portal"
  default     = ""

  validation {
    condition     = length(var.PARENT_ID) > 0
    error_message = "You must specify the parent_id from the platform in order to attach new aggregator instance."
  }
}

variable "DEPLOYMENT" {
  description = "MANDATORY - Unique name of the deployment. Multiple deployments of this stack in single VPC are supported (e.g. attempt1)"
  default     = "attempt1"
  
  validation {
    condition     = length(var.DEPLOYMENT) > 0
    error_message = "You must specify the deployment tag in order to separate deployments."
  }
}
