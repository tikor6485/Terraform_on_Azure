output "resource_group_id" {
  description = "Target resource group id used as RBAC scope."
  value       = data.azurerm_resource_group.rg.id
}

output "managed_identity_id" {
  description = "Azure resource ID of the user assigned managed identity."
  value       = azurerm_user_assigned_identity.uami.id
}

output "managed_identity_client_id" {
  description = "Client ID of the managed identity."
  value       = azurerm_user_assigned_identity.uami.client_id
}

output "managed_identity_principal_id" {
  description = "Principal (object) ID of the managed identity in Entra ID."
  value       = azurerm_user_assigned_identity.uami.principal_id
}

output "role_assignment_id" {
  description = "Role assignment id created at the resource group scope."
  value       = azurerm_role_assignment.uami_rg_role.id
}