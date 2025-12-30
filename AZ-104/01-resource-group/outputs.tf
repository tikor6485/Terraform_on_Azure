output "name_prefix" {
  description = "Standard name prefix derived from project + environment."
  value       = local.name_prefix
}

output "resource_group_name" {
  description = "Created resource group name."
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "Created resource group ARM ID."
  value       = azurerm_resource_group.this.id
}

output "location" {
  description = "Azure region where the resource group exists."
  value       = azurerm_resource_group.this.location
}

output "tags" {
  description = "Final merged tags applied to the resource group."
  value       = local.tags
}
