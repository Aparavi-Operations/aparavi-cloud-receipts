output "network_name" {
  value       = google_compute_network.this.name
  description = "Network name"
}

output "network_id" {
  value       = google_compute_network.this.id
  description = "Network ID"
}
