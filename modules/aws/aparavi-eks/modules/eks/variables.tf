variable "name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "aparavi"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  description = "List of subnet ID's in VPC"
  type        = list(string)
  default     = null
}

variable "instance_types" {
  description = "Set of instance types associated with default Node Group."
  type        = list(string)
  default     = ["t3.2xlarge"]
}
