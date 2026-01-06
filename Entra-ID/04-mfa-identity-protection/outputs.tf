output "tenant_id" {
  description = "Entra ID tenant ID."
  value       = data.azuread_client_config.current.tenant_id
}

output "conditional_access_policy_id" {
  description = "Conditional Access policy ID (if created)."
  value       = var.enable_conditional_access ? azuread_conditional_access_policy.require_mfa[0].id : null
}

output "conditional_access_policy_state" {
  description = "Configured policy state (intended)."
  value       = var.enable_conditional_access ? var.policy_state : null
}

output "conditional_access_policy_display_name" {
  description = "Policy display name (effective)."
  value       = local.effective_policy_display_name
}

output "included_group_object_ids" {
  description = "Resolved group object IDs (only when enabled)."
  value = var.enable_conditional_access ? {
    for k, g in data.azuread_group.included : k => g.object_id
  } : {}
}

output "excluded_user_object_ids" {
  description = "Resolved excluded user object IDs (only when enabled)."
  value = var.enable_conditional_access ? {
    for k, u in data.azuread_user.excluded : k => u.object_id
  } : {}
}
