output "vpc_id" {
  value       = module.network.vpc_id
  description = "The ID of the VPC"
}

output "private_subnet_ids" {
  value       = module.network.private_subnet_ids
  description = "List of IDs of private subnets"
}

output "public_subnet_ids" {
  value       = module.network.public_subnet_ids
  description = "List of IDs of public subnets"
}
