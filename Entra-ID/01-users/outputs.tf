/*
outputs.tf
- Exposes useful identifiers for reuse in later stacks (groups, role assignments, etc.).
*/

output "tenant_id" {
  description = "Tenant ID of the currently authenticated Entra directory."
  value       = data.azuread_client_config.current.tenant_id
}

output "created_user_ids" {
  description = "Map of created users: UPN => object_id."
  value       = { for upn, u in azuread_user.user : upn => u.object_id }
}

output "created_user_upns" {
  description = "List of created user principal names."
  value       = keys(azuread_user.user)
}
