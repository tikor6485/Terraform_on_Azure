# ------------------------------------------------------------
# AZ-104 / 04 - Network Stack
# Creates: Subnet + NSG + Public IP + NIC
# Reuses:  Resource Group (01) + Virtual Network (03)
# ------------------------------------------------------------

# Reuse the Resource Group from AZ-104/01-resource-group.
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Reuse the Virtual Network from AZ-104/03-virtual-network.
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Network Security Group: baseline security boundary for the subnet.
resource "azurerm_network_security_group" "nsg" {
  name                = "${local.name_prefix}-nsg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  # Guardrail: prevent accidental cross-region deployments.
  lifecycle {
    precondition {
      condition     = var.location == data.azurerm_resource_group.rg.location
      error_message = "location must match the Resource Group location. Set var.location to the RG region."
    }
    precondition {
      condition     = var.location == data.azurerm_virtual_network.vnet.location
      error_message = "location must match the VNet location. Ensure you're reusing the correct VNet."
    }
  }

  tags = local.tags
}

# Subnet: segment inside the VNet where NICs/VMs will attach.
resource "azurerm_subnet" "subnet" {
  name                 = "${local.name_prefix}-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# Associate NSG with the subnet (recommended baseline).
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Public IP: static + standard SKU for future internet-facing labs.
resource "azurerm_public_ip" "pip" {
  name                = "${local.name_prefix}-pip"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"

  # Guardrail: prevent accidental cross-region deployments.
  lifecycle {
    precondition {
      condition     = var.location == data.azurerm_resource_group.rg.location
      error_message = "location must match the Resource Group location. Set var.location to the RG region."
    }
  }

  tags = local.tags
}

# Network Interface: attaches to subnet and optionally gets a Public IP.
resource "azurerm_network_interface" "nic" {
  name                = "${local.name_prefix}-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  # Guardrail: prevent accidental cross-region deployments.
  lifecycle {
    precondition {
      condition     = var.location == data.azurerm_resource_group.rg.location
      error_message = "location must match the Resource Group location. Set var.location to the RG region."
    }
  }

  tags = local.tags

  depends_on = [
    azurerm_subnet_network_security_group_association.subnet_nsg
  ]
}
