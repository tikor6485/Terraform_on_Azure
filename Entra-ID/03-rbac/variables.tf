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
  description = "Environment label."
  default     = "dev"
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
# Scope (default: Resource Group)
# -------------------------

variable "resource_group_name" {
  type        = string
  description = "Existing Resource Group name to use as the RBAC scope."
}

# -------------------------
# RBAC assignments
# -------------------------

variable "assignments" {
  description = <<EOT
List of RBAC assignments to create at the Resource Group scope.

Exactly ONE of these must be set per item:
- principal_object_id
- user_upn
- group_display_name

role_name must be a built-in role name (e.g., Reader, Contributor, Monitoring Reader, etc.)
EOT

  type = list(object({
    # Stable key to avoid accidental recreation if you reorder the list.
    key = string

    role_name = string

    principal_object_id = optional(string)
    user_upn            = optional(string)
    group_display_name  = optional(string)

    # Optional: skip AAD check (sometimes helpful for SPs; usually not needed for users/groups).
    skip_service_principal_aad_check = optional(bool, false)
  }))

  default = []

  validation {
    condition = alltrue([
      for a in var.assignments : (
        length(trimspace(a.key)) > 0 &&
        length(trimspace(a.role_name)) > 0 &&
        (
          (try(a.principal_object_id, null) != null ? 1 : 0) +
          (try(a.user_upn, null) != null ? 1 : 0) +
          (try(a.group_display_name, null) != null ? 1 : 0)
        ) == 1
      )
    ])
    error_message = "Each assignment must have non-empty key/role_name and exactly ONE principal selector: principal_object_id OR user_upn OR group_display_name."
  }
}
variable "subscription_id" {
  type        = string
  description = "Optional. Azure Subscription ID. If empty, provider uses Azure CLI context or ARM_SUBSCRIPTION_ID."
  default     = ""
}

variable "tenant_id" {
  type        = string
  description = "Optional. Azure Tenant ID. If empty, provider uses Azure CLI context or ARM_TENANT_ID."
  default     = ""
}

