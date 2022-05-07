output "cluster_id" {
  value       = aws_eks_cluster.this.id
  description = "The name/id of the EKS cluster"
}
