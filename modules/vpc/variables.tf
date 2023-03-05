variable "project_id" {
  description = "The project ID to create the resources in."
}

variable "region" {
  description = "The region to create the resources in."
  default     = "europe-west2"
}

variable "subnet_cidr" {
  description = "CIDR block for the VPC subnet."
  default     = "10.0.0.0/24"
}

variable "cluster_name" {
  description = "The name of the GKE cluster to create."
  default     = "gke-private-cluster"
}

variable "nodepool_1_name" {
  description = "The name of the first node pool to create."
  default     = "pool1"
}

variable "nodepool_2_name" {
  description = "The name of the second node pool to create."
  default     = "pool2"
}

variable "nodepool_1_machine_type" {
  description = "The machine type of the first node pool."
  default     = "e2-medium"
}

variable "nodepool_2_machine_type" {
  description = "The machine type of the second node pool."
  default     = "e2-medium"
}

variable "nodepool_1_num_nodes" {
  description = "The number of nodes in the first node pool."
  default     = 3
}

variable "nodepool_2_num_nodes" {
  description = "The number of nodes in the second node pool."
  default     = 0
}

variable "nodepool_2_max_nodes" {
  description = "The maximum number of nodes for the second node pool autoscaler."
  default     = 3
}

variable "service_account_name" {
  description = "The name of the service account to create."
  default     = "my-service-account"
}

variable "service_account_display_name" {
  description = "The display name of the service account to create."
  default     = "My Service Account"
}
