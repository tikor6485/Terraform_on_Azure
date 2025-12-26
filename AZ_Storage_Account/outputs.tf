output "resource_group_name" {
  value = azurerm_resource_group.tirdad.name
}

output "storage_account_name" {
  value = azurerm_storage_account.tirdad.name
}

output "storage_account_id" {
  value = azurerm_storage_account.tirdad.id
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.tirdad.primary_blob_endpoint
}

output "container_name" {
  value = azurerm_storage_container.tirdad.name
}
