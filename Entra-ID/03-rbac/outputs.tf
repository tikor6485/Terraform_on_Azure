output "tenant_id" {
  description = "Entra tenant id."
  value       = data.azuread_client_config.current.tenant_id
}

output "resource_group_id" {
  description = "Scope id used for RBAC assignments."
  value       = data.azurerm_resource_group.rg.id
}

output "role_assignment_ids" {
  description = "Map of assignment key -> role assignment id."
  value = {
    for k, ra in azurerm_role_assignment.rg : k => ra.id
  }
}
