variable "bigquery_role_assignment" {
  type = map(object({
    role = string
    user = string
  }))
}

variable "dataset_id" {}
