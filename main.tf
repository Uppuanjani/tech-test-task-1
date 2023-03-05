# Configure the Google Cloud provider
provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}

# Variables
variable "credentials_file" {
  description = "The path to the GCP credentials file"
  default     = "service-account.json"
}

variable "project_id" {
  description = "The ID of the GCP project"
  default     = "astral-bazaar-379514"
}

variable "region" {
  description = "The GCP region in which resources will be created"
  default     = "europe-west2"
}

variable "cidr_blocks" {
  description = "CIDR blocks for each of the subnets"
  type        = map(string)
  default = {
    vpc_network = "10.0.0.0/16"
    london_subnet = "10.0.1.0/24"
  }
}

variable "node_pools" {
  description = "Node pool configurations"
  type        = list(object({
    name         = string
    machine_type = string
    disk_size_gb = number
    disk_type    = string
    initial_node_count = number
    max_node_count     = number
    min_node_count     = number
    auto_repair        = bool
    auto_upgrade       = bool
    preemptible        = bool
  }))
  default = [
    {
      name               = "pool-1"
      machine_type       = "e2-medium"
      disk_size_gb       = 10
      disk_type          = "pd-standard"
      initial_node_count = 3
      max_node_count     = null
      min_node_count     = null
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
    },
    {
      name               = "pool-2"
      machine_type       = "e2-medium"
      disk_size_gb       = 10
      disk_type          = "pd-standard"
      initial_node_count = 0
      max_node_count     = null
      min_node_count     = null
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = true
    }
  ]
}

# Create a new VPC network with custom subnets
module "vpc" {
  source = "./modules/vpc"
  project_id = var.project_id
  region = var.region
  cidr_blocks = var.cidr_blocks
}

# Create a private GKE cluster using the custom VPC network and subnets
resource "google_container_cluster" "private_cluster" {
  name     = "private-cluster"
  location = var.region

  remove_default_node_pool = true

  network    = module.vpc.vpc_self_link
  subnetwork = module.vpc.subnet_self_links["london_subnet"]

  ip_allocation_policy {
    use_ip_aliases = true
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "0.0.0.0/0"
      display_name = "all"
    }
  }

  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    service_account = module.vpc.k8s_service_account_email
    preemptible     = false
  }

  addons_config {
    network_policy_config {
      enabled = true
    }
  }

    timeouts {
      create = "60m"
      delete = "120m"
    }
}

module "bigquery_roles" {
  source = "./modules/bigquery_roles"

  bigquery_role_assignment = {
    vmo2_tech_test = {
      role = "roles/bigquery.dataEditor"
      user = var.user_email
    }
  }

  dataset_id = google_bigquery_dataset.vmo2_tech_test.dataset_id
}

output "cluster_endpoint" {
  value = google_container_cluster.gke.private_cluster_endpoint
}

output "bigquery_dataset_id" {
  value = google_bigquery_dataset.vmo2_tech_test.dataset_id
}
