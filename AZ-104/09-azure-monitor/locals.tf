# Centralized naming and tagging conventions for the stack.
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
}
