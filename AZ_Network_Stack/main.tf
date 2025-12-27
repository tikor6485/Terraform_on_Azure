# Resource Group: logical container for all resources in this demo.
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_prefix}-${var.environment}-rg"
  location = var.location

  tags = {
    demo        = "az-network-stack"
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Virtual Network (VNet): private network boundary in Azure.
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix}-${var.environment}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space

  tags = {
    demo        = "az-network-stack"
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Subnet: a segment inside the VNet where NICs/VMs attach.
resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource_prefix}-${var.environment}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# Public IP: allocates a public address (useful for internet-facing workloads).
resource "azurerm_public_ip" "pip" {
  name                = "${var.resource_prefix}-${var.environment}-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"

  tags = {
    demo        = "az-network-stack"
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Network Interface (NIC): connects a compute resource (like a VM) to the subnet and optional public IP.
resource "azurerm_network_interface" "nic" {
  name                = "${var.resource_prefix}-${var.environment}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = {
    demo        = "az-network-stack"
    environment = var.environment
    managed_by  = "terraform"
  }
}
