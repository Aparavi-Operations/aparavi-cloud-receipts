output "endpoint" {
  description = "GKE Cluster endpoint"
  value       = google_container_cluster.this.endpoint
}

output "cluster_ca_certificate" {
  description = "GKE Cluster CA certificate"
  value       = google_container_cluster.this.master_auth.0.cluster_ca_certificate
}
