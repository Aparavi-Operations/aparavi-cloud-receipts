variable "name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "aparavi"
}

variable "master_version" {
  description = "Kubernetes master version"
  type        = string
  default     = "1.22"
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to Kubernetes API"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID to deploy the cluster in"
  type        = string
  default     = null
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

variable "min_size" {
  description = "'default' node group min_size"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "'default' node group max_size"
  type        = number
  default     = 2
}

variable "desired_size" {
  description = "'default' node group desired_size"
  type        = number
  default     = 2
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "cluster_tags" {
  description = "A map of additional tags to add to the cluster"
  type        = map(string)
  default     = {}
}

variable "cluster_iam_role_tags" {
  description = "A map of additional tags to add to the cluster IAM role"
  type        = map(string)
  default     = {}
}

variable "node_iam_role_tags" {
  description = "A map of additional tags to add to default NG IAM role"
  type        = map(string)
  default     = {}
}
