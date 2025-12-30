output "resource_group_name" {
  description = "Resource Group name."
  value       = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "Resource Group ID."
  value       = azurerm_resource_group.rg.id
}

output "vnet_name" {
  description = "Virtual Network name."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Virtual Network ID."
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_address_space" {
  description = "Virtual Network address space."
  value       = azurerm_virtual_network.vnet.address_space
}
