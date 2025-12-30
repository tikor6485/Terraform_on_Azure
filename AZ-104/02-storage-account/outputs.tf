# Shows the created Resource Group name.
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

# Shows the Storage Account name (useful for portal/CLI lookups).
output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

# Shows the Storage Account resource ID.
output "storage_account_id" {
  value = azurerm_storage_account.sa.id
}

# Shows the primary Blob endpoint URL.
output "primary_blob_endpoint" {
  value = azurerm_storage_account.sa.primary_blob_endpoint
}

# Shows the created container name.
output "container_name" {
  value = azurerm_storage_container.container.name
}
