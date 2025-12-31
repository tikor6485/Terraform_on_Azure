# ------------------------------------------------------------
# AZ-104 / 03 - Virtual Network (reuse RG, standard naming/tags)
# ------------------------------------------------------------

# Reuse the Resource Group from AZ-104/01-resource-group.
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Virtual Network in the existing Resource Group.
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name_prefix}-vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  address_space       = var.vnet_address_space

  # Guardrail: prevent accidental cross-region deployments.
  lifecycle {
    precondition {
      condition     = var.location == data.azurerm_resource_group.rg.location
      error_message = "location must match the Resource Group location. Set var.location to the RG region."
    }
  }

  tags = local.tags
}
