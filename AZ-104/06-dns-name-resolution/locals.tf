locals {
  name_prefix = "${var.project}-${var.environment}"

  private_dns_zone_name = var.private_dns_zone_name != "" ? var.private_dns_zone_name : "${local.name_prefix}.internal"

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
