output "cluster_endpoint" {
  description = "The endpoint of the GKE cluster."
  value       = google_container_cluster.private.endpoint
}

output "cluster_ca_certificate" {
  description = "The CA certificate used by the GKE cluster."
  value       = google_container_cluster.private.master_auth.0.cluster_ca_certificate
}

output "nodepool_1_name" {
  description = "The name of the first node pool."
  value       = google_container_node_pool.nodepool_1.name
}

output "nodepool_2_name" {
  description = "The name of the second node pool."
  value       = google_container_node_pool.nodepool_2.name
}

output "nodepool_2_max_nodes" {
  description = "The maximum number of nodes for the second node pool autoscaler."
  value       = google_container_node_pool.nodepool_2.autoscaling.0.max_node_count
}

output "service_account_email" {
  description = "The email address of the service account."
  value       = google_service_account.service_account.email
}
