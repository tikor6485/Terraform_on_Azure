locals {
  rg_name = "${var.resource_prefix}-${var.environment}-rg"
}

resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = var.location

  tags = merge(
    {
      environment = var.environment
      managed_by  = "terraform"
      demo        = "az-resource-groups"
    },
    var.tags
  )
}
