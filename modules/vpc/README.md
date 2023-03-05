# Terraform GKE Cluster

This Terraform code provisions a regional private Kubernetes cluster on GKE with a dedicated service account, new VPC, and a subnet created in the London region. The cluster uses RFC1918 24-bit block CIDR ranges, has two node pools (one with 3 nodes without auto-scaling and another with 0 nodes by default with auto-scaling enabled), and allows outbound internet access without assigning external IP addresses to it.

## Prerequisites
1. Install [Terraform](https://www.terraform.io/downloads.html) (version >= 0.12)
2. Create a [Google Cloud Platform](https://cloud.google.com/) account
3. Set up a [GCP service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts) with `Editor` role and download the service account JSON key

## How to use
1. Clone the repository
2. Replace the placeholders in `variables.tf` file with your own values
3. Copy and paste the downloaded `service-account.json` file to the root of the cloned repository
4. Run the following commands in the cloned repository directory:



## Variables
| Variable Name | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `project_id` | string | Yes | | The GCP project ID |
| `region` | string | Yes | | The region to create the resources |
| `cluster_name` | string | Yes | | The name of the GKE cluster |
| `vpc_name` | string | Yes | | The name of the VPC to be created |
| `subnet_name` | string | Yes | | The name of the subnet to be created |
| `cidr_block` | string | Yes | | The CIDR block of the VPC |
| `sub_cidr_block` | string | Yes | | The CIDR block of the subnet |
| `service_account_email` | string | Yes | | The email of the service account to be created |
| `node_pool_name` | string | Yes | | The name of the node pool |
| `node_count` | number | Yes | | The number of nodes in the node pool without auto-scaling |
| `auto_scaling_node_pool_name` | string | Yes | | The name of the auto-scaling node pool |
| `min_node_count` | number | Yes | 0 | The minimum number of nodes in the auto-scaling node pool |
| `max_node_count` | number | Yes | 3 | The maximum number of nodes in the auto-scaling node pool |
| `preemptible` | bool | Yes | true | Whether to allow preemptible nodes in the auto-scaling node pool |

## Outputs
| Output Name | Description |
| --- | --- |
| `cluster_endpoint` | The endpoint of the GKE cluster |
| `cluster_ca_certificate` | The CA certificate of the GKE cluster |
| `kubeconfig` | The kubeconfig file to use for connecting to the GKE cluster |

