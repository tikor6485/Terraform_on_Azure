# -------------------------
# Core naming + tagging inputs
# -------------------------

variable "project" {
  type        = string
  description = "Project identifier used in naming and tagging."
  default     = "entra-id"
}

variable "environment" {
  type        = string
  description = "Environment label (e.g., dev, test, prod)."
  default     = "lab"
}

variable "location" {
  type        = string
  description = "Azure region (must match the RG region for consistency)."
  default     = "northeurope"
}

variable "owner" {
  type        = string
  description = "Owner tag (team/person)."
  default     = ""
}

variable "cost_center" {
  type        = string
  description = "Cost center tag."
  default     = ""
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to merge into the standard tag set."
  default     = {}
}

# -------------------------
# Dependencies / Scope
# -------------------------

variable "resource_group_name" {
  type        = string
  description = "Existing Resource Group name to scope RBAC (default: az-104-dev-rg)."
}

# -------------------------
# Managed Identity
# -------------------------

variable "managed_identity_name" {
  type        = string
  description = "Name for the User Assigned Managed Identity."
  default     = "entra-id-lab-uami"
}

variable "role_definition_name" {
  type        = string
  description = "Built-in role to assign to the managed identity at RG scope."
  default     = "Reader"
}