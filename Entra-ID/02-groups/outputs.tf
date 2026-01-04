output "tenant_id" {
  description = "Entra tenant ID."
  value       = data.azuread_client_config.current.tenant_id
}

output "created_group_ids" {
  description = "Map of created group IDs by group key."
  value = {
    for k, g in azuread_group.group :
    k => g.id
  }
}

output "created_group_object_ids" {
  description = "Map of created group object IDs by group key."
  value = {
    for k, g in azuread_group.group :
    k => g.object_id
  }
}

output "created_group_display_names" {
  description = "List of created group display names."
  value       = [for g in azuread_group.group : g.display_name]
}
