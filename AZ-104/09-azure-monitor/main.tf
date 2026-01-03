# ---------------------------------------------
# Data source: reuse existing Resource Group
# ---------------------------------------------
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# ---------------------------------------------
# Log Analytics Workspace
# ---------------------------------------------
resource "azurerm_log_analytics_workspace" "law" {
  name                = "${local.name_prefix}-law"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku               = var.log_analytics_sku
  retention_in_days = var.log_retention_days

  tags = local.tags
}

# ---------------------------------------------
# Application Insights (workspace-based)
# ---------------------------------------------
resource "azurerm_application_insights" "appi" {
  count               = var.enable_application_insights ? 1 : 0
  name                = "${local.name_prefix}-appi"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  application_type = var.application_insights_type

  # Workspace-based Application Insights (recommended).
  workspace_id = azurerm_log_analytics_workspace.law.id

  tags = local.tags
}

# ---------------------------------------------
# Diagnostic Setting (optional)
# ---------------------------------------------
# IMPORTANT:
# - Categories differ per resource type.
# - Provide diag_target_resource_id + categories via env vars or tfvars.
resource "azurerm_monitor_diagnostic_setting" "diag" {
  count = var.diag_target_resource_id != "" ? 1 : 0

  name               = "${local.name_prefix}-diag"
  target_resource_id = var.diag_target_resource_id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  dynamic "enabled_log" {
    for_each = toset(var.diag_log_categories)
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = toset(var.diag_metric_categories)
    content {
      category = metric.value
      enabled  = true
    }
  }
}
