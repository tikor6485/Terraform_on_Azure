# ------------------------------------------------------------
# Locals: consistent naming and tagging across stacks
# ------------------------------------------------------------

locals {
  # Name prefix used across resources (matches other AZ-104 stacks)
  name_prefix = "${var.project}-${var.environment}"

  # Standard tags (keep minimal and consistent)
  tags = merge(
    {
      project     = var.project
      environment = var.environment
      managed_by  = "terraform"

      # Optional tags: use null to omit in Azure
      owner       = var.owner != "" ? var.owner : null
      cost_center = var.cost_center != "" ? var.cost_center : null
    },
    var.additional_tags
  )

  # Resource names
  public_ip_name = "${local.name_prefix}-pip-lb"
  lb_name        = "${local.name_prefix}-lb"
  fe_name        = "${local.name_prefix}-fe"
  be_pool_name   = "${local.name_prefix}-bepool"
  probe_name     = "${local.name_prefix}-probe"
  rule_name      = "${local.name_prefix}-lbrule"

  # Convert backend NICs list to a map for stable for_each keys
  backend_nic_map = {
    for idx, item in var.backend_nics :
    "${idx}-${replace(basename(item.nic_id), "/", "_")}-${item.ip_configuration_name}" => item
  }
}
