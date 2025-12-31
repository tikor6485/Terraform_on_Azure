output "resource_group_name" {
  value = data.azurerm_resource_group.rg.name
}

output "location" {
  value = var.location
}

output "name_prefix" {
  value = local.name_prefix
}

output "tags" {
  value = local.tags
}

output "vnet_name" {
  value = data.azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = data.azurerm_virtual_network.vnet.id
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "public_ip_name" {
  value = azurerm_public_ip.pip.name
}

output "public_ip_id" {
  value = azurerm_public_ip.pip.id
}

output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}

output "nic_name" {
  value = azurerm_network_interface.nic.name
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}
