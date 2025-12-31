locals {
  # Standard prefix used across AZ-104 stacks.
  name_prefix = "${var.project}-${var.environment}"

  # Standard tags merged with user-provided tags.
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
}
