# ------------------------------------------------------------
# Common naming + tagging locals (aligned across AZ-104 folders)
# ------------------------------------------------------------

locals {
  # Standard prefix used across all stacks.
  # Example: az-104-dev
  name_prefix = "${var.project}-${var.environment}"

  # Standard tags applied across resources.
  tags = merge(
    {
      project     = var.project
      environment = var.environment
      managed_by  = "terraform"
      owner       = var.owner
      cost_center = var.cost_center
    },
    var.additional_tags
  )
}
