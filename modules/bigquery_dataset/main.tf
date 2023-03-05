variable "bigquery_role_assignment" {
  type = map(object({
    role = string
    user = string
  }))
}

variable "dataset_id" {}

resource "google_bigquery_dataset_access" "this" {
  for_each = var.bigquery_role_assignment

  dataset_id = var.dataset_id
  role       = each.value.role
  user_by_email {
    email = each.value.user
  }
}
