output "resource_group_name" {
  value       = azurerm_resource_group.this.name
  description = "The name of the created Resource Group"
}

output "resource_group_id" {
  value       = azurerm_resource_group.this.id
  description = "The resource ID of the created Resource Group"
}
