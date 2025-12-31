# ------------------------------------------------------------
# AZ-104 / 05 - Linux VM
# Creates: Linux VM
# Reuses:  Resource Group (01) + NIC/NSG/PIP (04)
# Option:  Adds SSH rule on existing NSG (subnet-level)
# ------------------------------------------------------------

# Reuse the Resource Group from AZ-104/01-resource-group.
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Reuse NIC from AZ-104/04-network-stack.
data "azurerm_network_interface" "nic" {
  name                = var.nic_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Reuse NSG from AZ-104/04-network-stack (subnet-level NSG).
data "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Reuse Public IP from AZ-104/04-network-stack.
data "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Optional: allow SSH on the existing subnet NSG.
# Note: NSG itself is created in stack 04; this stack manages only the rule.
resource "azurerm_network_security_rule" "allow_ssh" {
  count = var.enable_ssh ? 1 : 0

  name                       = "${local.name_prefix}-allow-ssh"
  priority                   = var.ssh_rule_priority
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefixes    = var.ssh_source_cidrs
  destination_address_prefix = "*"

  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = data.azurerm_network_security_group.nsg.name
}

# Linux VM attached to the existing NIC.
resource "azurerm_linux_virtual_machine" "vm" {
  name                = (var.vm_name != "" ? var.vm_name : "${local.name_prefix}-vm")
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  size                = var.vm_size

  admin_username                  = var.admin_username
  disable_password_authentication = true

  network_interface_ids = [
    data.azurerm_network_interface.nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  # cloud-init must be base64-encoded; if file is missing, set to null.
  custom_data = try(base64encode(file(var.cloud_init_file)), null)

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Ubuntu 22.04 LTS
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  # Guardrails: prevent accidental cross-region deployments.
  lifecycle {
    precondition {
      condition     = var.location == data.azurerm_resource_group.rg.location
      error_message = "location must match the Resource Group location. Set var.location to the RG region."
    }
    precondition {
      condition     = var.location == data.azurerm_network_interface.nic.location
      error_message = "location must match the NIC location. Ensure you're reusing the correct NIC."
    }
  }

  tags = local.tags

  depends_on = [
    azurerm_network_security_rule.allow_ssh
  ]
}
