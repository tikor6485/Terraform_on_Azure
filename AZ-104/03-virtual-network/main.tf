# Create a Resource Group to logically group all demo resources together.
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_prefix}-${var.environment}-rg"
  location = var.location

  tags = {
    demo        = "az-virtual-network"
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Create a Virtual Network (VNet) as the network boundary for Azure resources.
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix}-${var.environment}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # VNet CIDR(s). Example: ["10.10.0.0/16"]
  address_space = var.vnet_address_space

  tags = {
    demo        = "az-virtual-network"
    environment = var.environment
    managed_by  = "terraform"
  }
}
