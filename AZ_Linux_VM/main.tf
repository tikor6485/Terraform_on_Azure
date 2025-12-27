# Random suffix to avoid name collisions for resources that need uniqueness (or to keep demos consistent).
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
  numeric = true
  lower   = true
}

locals {
  demo_tag = "az-linux-vm"

  rg_name     = "${var.resource_prefix}-${var.environment}-rg"
  vnet_name   = "${var.resource_prefix}-${var.environment}-vnet"
  subnet_name = "${var.resource_prefix}-${var.environment}-subnet"
  nsg_name    = "${var.resource_prefix}-${var.environment}-nsg"
  pip_name    = "${var.resource_prefix}-${var.environment}-pip"
  nic_name    = "${var.resource_prefix}-${var.environment}-nic"
  vm_name     = "${var.resource_prefix}-${var.environment}-vm"

  # file() does not expand "~" unless we expand it first.
  ssh_key_path = pathexpand(var.ssh_public_key_path)

  tags = {
    demo        = local.demo_tag
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Resource Group: logical container for everything in this demo.
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

# Virtual Network (VNet): private network boundary in Azure.
resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
  tags                = local.tags
}

# Subnet: network segment inside the VNet where the VM NIC attaches.
resource "azurerm_subnet" "subnet" {
  name                 = local.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# NSG: basic firewall rules for the subnet/NIC (SSH + HTTP).
resource "azurerm_network_security_group" "nsg" {
  name                = local.nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Public IP: static public address for the VM (via NIC association).
resource "azurerm_public_ip" "pip" {
  name                = local.pip_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"

  tags = local.tags
}

# Network Interface: attaches VM to subnet and public IP.
resource "azurerm_network_interface" "nic" {
  name                = local.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# Associate NSG with the NIC.
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Linux VM: uses file() for SSH key and filebase64() for cloud-init custom_data.
resource "azurerm_linux_virtual_machine" "vm" {
  name                = local.vm_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(local.ssh_key_path)
  }

  # cloud-init will run on first boot (install nginx + write a test page).
  custom_data = filebase64(var.cloud_init_file)

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = local.tags
}
