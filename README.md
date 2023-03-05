# Terraform Tasks

This repository contains the code for two Terraform tasks.

## Task 1

This task involves creating a Virtual Private Cloud (VPC) on Google Cloud Platform (GCP) using Terraform. The following steps are required:

1. Create a VPC with a custom subnet.
2. Create a firewall rule that allows incoming traffic on port 80.
3. Create a service account with the necessary roles.
4. Assign the service account to the VPC with the necessary roles.

### Usage

1. Set up your GCP authentication:
   ```bash
   export GOOGLE_CLOUD_KEYFILE_JSON=<path_to_your_service_account_key_file>
   export GOOGLE_PROJECT=<your_gcp_project_id>

2. Run Terraform.

```
terraform init
terraform apply
```

# Task 2

This task involves creating a new BigQuery dataset and assigning specific roles to specific datasets using a local Terraform module. The following steps are required.

1.Create a new BigQuery dataset.
2.Create a local module that assigns specific roles to specific datasets.
3.Use the module to assign roles to the newly created dataset.