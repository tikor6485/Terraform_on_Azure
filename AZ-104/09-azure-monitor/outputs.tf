# Useful outputs for integration with other stacks.

output "name_prefix" {
  description = "Common name prefix used by this stack."
  value       = local.name_prefix
}

output "resource_group_name" {
  description = "Resource Group name used by this stack."
  value       = data.azurerm_resource_group.rg.name
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.law.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.law.name
}

output "log_analytics_workspace_workspace_id" {
  description = "Workspace ID (GUID) of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.law.workspace_id
}

output "application_insights_id" {
  description = "Resource ID of Application Insights (if enabled)."
  value       = var.enable_application_insights ? azurerm_application_insights.appi[0].id : null
}

output "application_insights_connection_string" {
  description = "Application Insights connection string (if enabled)."
  value       = var.enable_application_insights ? azurerm_application_insights.appi[0].connection_string : null
  sensitive   = true
}

output "diagnostic_setting_id" {
  description = "Diagnostic Setting resource ID (if created)."
  value       = var.diag_target_resource_id != "" ? azurerm_monitor_diagnostic_setting.diag[0].id : null
}

output "tags" {
  description = "Tags applied to resources."
  value       = local.tags
}
