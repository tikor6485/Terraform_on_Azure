locals {
  # Standard prefix used across resources (consistent, predictable).
  name_prefix = "${var.project}-${var.environment}"

  # Resource Group naming: hyphens are allowed; keep it readable.
  rg_name = var.resource_group_name_override != "" ? var.resource_group_name_override : "${local.name_prefix}-rg"

  # Standard baseline tags used across this repo.
  base_tags = {
    project     = var.project
    environment = var.environment
    owner       = var.owner
    cost_center = var.cost_center
    managed_by  = "terraform"
  }

  # Final tags = base tags + user-provided additions (user tags win on conflicts).
  tags = merge(local.base_tags, var.additional_tags)
}
