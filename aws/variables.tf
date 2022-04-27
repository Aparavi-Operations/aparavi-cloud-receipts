# Global
variable "ACCOUNT_ID" {
  description = "MANDATORY Account ID to deploy to"
  default     = ""
}

variable "REGION" {
  description = "MANDATORY Availability Zone to deploy EC2 instances (e.g. us-east-1)"
  default     = ""
}

# EC2 Settings
variable "KEY_NAME" {
  description = "MANDATORY SSH Key name to attach to ec2 instances"
  default     = "hello"
}

variable "AGGREGATOR_EBS_SIZE" {
  description = "MANDATORY The aggregator disk size in GB (e.g. 50)"
  default     = "250"
}

variable "COLLECTOR_EBS_SIZE" {
  description = "MANDATORY The collector disk size in GB (e.g. 50)"
  default     = "250"
}

# Network and security
variable "MANAGEMENT_NETWORK" {
  description = "MANDATORY Management network to allow connections in"
  default     = "0.0.0.0/0"
}

variable "PUBLIC" {
  description = "Whether to deploy EC2 in Public subnets"
  default     = "true"
}

# Aggregator settings
variable "AGGREGATOR_ENABLED" {
  description = "Deploy aggregator stack or not"
  default     = "True"
}

variable "AGGREGATOR_INSTANCE_TYPE" {
  description = "Type of AWS instance"
  default     = "t3.medium"
}

variable "PLATFORM" {
  description = "MANDATORY Platform to attach aggregator to"
  default     = "preview.aparavi.com"
}

variable "PARENT_ID" {
  description = "ID from Aparavi Portal"
  default     = ""
}

# Collector setings
variable "COLLECTOR_ENABLED" {
  description = "Deploy collector stack or not"
  default     = "True"
}

variable "COLLECTOR_INSTANCE_TYPE" {
  description = "Type of AWS instance"
  default     = "t3.medium"
}

# Monitoring settings
variable "MONITORING_ENABLED" {
  description = "Deploy monitoring stack or not"
  default     = "True"
}

# Other settings
variable "DEPLOYMENT" {
  description = "MANDATORY Unique name of the deployment. Multiple deployments of this stack in single VPC are supported"
  default     = "test"
}