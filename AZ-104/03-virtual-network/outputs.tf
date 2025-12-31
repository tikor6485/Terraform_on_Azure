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
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_address_space" {
  value = azurerm_virtual_network.vnet.address_space
}
