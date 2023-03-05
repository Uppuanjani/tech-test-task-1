output "dataset_accesses" {
  value = toset([
    for dataset, role_assignment in var.bigquery_role_assignment : {
      dataset = dataset
      role_assignment = role_assignment
    }
  ])
}
