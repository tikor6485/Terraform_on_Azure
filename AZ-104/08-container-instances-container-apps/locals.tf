// Local values for consistent naming and tagging.

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

  container_group_name = var.container_group_name != "" ? var.container_group_name : "${local.name_prefix}-aci"

  # If you set dns_name_label, consider using a unique value per user/subscription to avoid collisions.
  effective_dns_name_label = var.dns_name_label != "" ? var.dns_name_label : null
}
