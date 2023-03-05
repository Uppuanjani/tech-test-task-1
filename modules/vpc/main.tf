variable "project_id" {}

variable "region" {}

variable "subnet_cidr" {}

variable "cluster_cidr" {}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "terraform-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
}

resource "google_compute_global_address" "nat_ip" {
  name            = "terraform-nat-ip"
  purpose         = "NAT_AUTO_ONLY
