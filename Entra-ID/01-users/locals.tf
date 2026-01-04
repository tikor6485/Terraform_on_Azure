/*
locals.tf
- Common naming and tag conventions used across the repository.
- Tags are kept here for consistency even though Entra user resources do not support tags.
*/

locals {
  # Consistent name prefix across stacks
  name_prefix = "${var.project}-${var.environment}"

  # Standard tag set (used by Azure resources; not applicable to Entra users)
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
