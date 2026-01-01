output "resource_group_name" {
  value = data.azurerm_resource_group.rg.name
}

output "vnet_name" {
  value = data.azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = data.azurerm_virtual_network.vnet.id
}

output "name_prefix" {
  value = local.name_prefix
}

output "tags" {
  value = local.tags
}

output "private_dns_zone_name" {
  value = azurerm_private_dns_zone.zone.name
}

output "private_dns_zone_id" {
  value = azurerm_private_dns_zone.zone.id
}

output "vnet_link_id" {
  value = azurerm_private_dns_zone_virtual_network_link.link.id
}

output "test_a_record_fqdn" {
  value = try(azurerm_private_dns_a_record.test[0].fqdn, null)
}
