# -------------------------
# Core naming + tagging inputs
# -------------------------

variable "project" {
  type        = string
  description = "Project identifier used in naming and tagging (e.g., az-104)."
  default     = "az-104"
}

variable "environment" {
  type        = string
  description = "Environment label (e.g., dev, test, prod)."
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Azure region for Monitor resources. Prefer to match the Resource Group region."
  default     = "northeurope"
}

variable "owner" {
  type        = string
  description = "Owner tag (team/person). Optional."
  default     = ""
}

variable "cost_center" {
  type        = string
  description = "Cost center tag. Optional."
  default     = ""
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to merge into the standard tag set."
  default     = {}
}

# -------------------------
# Dependencies (from previous stacks)
# -------------------------

variable "resource_group_name" {
  type        = string
  description = "Existing Resource Group name to reuse (created by AZ-104/01-resource-group)."
}

# -------------------------
# Log Analytics Workspace
# -------------------------

variable "log_analytics_sku" {
  type        = string
  description = "Log Analytics Workspace SKU (e.g., PerGB2018)."
  default     = "PerGB2018"
}

variable "log_retention_days" {
  type        = number
  description = "Log retention in days for the workspace."
  default     = 30
}

# -------------------------
# Application Insights (optional, workspace-based)
# -------------------------

variable "enable_application_insights" {
  type        = bool
  description = "If true, creates Application Insights connected to the Log Analytics workspace."
  default     = true
}

variable "application_insights_type" {
  type        = string
  description = "Application Insights application type (common values: web, other)."
  default     = "web"
}

# -------------------------
# Diagnostic Settings (optional)
# -------------------------

variable "diag_target_resource_id" {
  type        = string
  description = "Target resource ID for Diagnostic Settings. If empty, no diagnostic setting is created."
  default     = ""
}

variable "diag_log_categories" {
  type        = list(string)
  description = "List of log categories to enable in the Diagnostic Setting. Categories depend on resource type."
  default     = []
}

variable "diag_metric_categories" {
  type        = list(string)
  description = "List of metric categories to enable in the Diagnostic Setting (often: [\"AllMetrics\"])."
  default     = []
}
