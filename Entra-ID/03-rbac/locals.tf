locals {
  name_prefix = "${var.project}-${var.environment}"

  tags = merge(
    {
      project     = var.project
      environment = var.environment
      managed_by  = "terraform"
      owner       = var.owner != "" ? var.owner : null
      cost_center = var.cost_center != "" ? var.cost_center : null
    },
    var.additional_tags
  )

  # Partition assignments by the way we resolve principals.
  assignments_by_upn = {
    for a in var.assignments : a.key => a
    if try(a.user_upn, null) != null
  }

  assignments_by_group_name = {
    for a in var.assignments : a.key => a
    if try(a.group_display_name, null) != null
  }

  assignments_by_object_id = {
    for a in var.assignments : a.key => a
    if try(a.principal_object_id, null) != null
  }
}
