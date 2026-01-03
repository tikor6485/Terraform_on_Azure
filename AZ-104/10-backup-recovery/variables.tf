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
# Dependencies (from previous stacks)
# -------------------------

variable "resource_group_name" {
  type        = string
  description = "Existing Resource Group name to reuse (created by AZ-104/01-resource-group)."
}

# -------------------------
# Recovery Services Vault settings
# -------------------------

variable "vault_sku" {
  type        = string
  description = "Recovery Services Vault SKU. Typical values: Standard."
  default     = "Standard"
}

variable "soft_delete_enabled" {
  type        = bool
  description = "Enable soft delete for the vault (recommended)."
  default     = true
}

# -------------------------
# VM Backup policy settings
# -------------------------

variable "backup_timezone" {
  type        = string
  description = "Timezone used by the VM backup policy schedule."
  default     = "UTC"
}

variable "backup_time" {
  type        = string
  description = "Daily backup time in HH:MM format (24h). Example: 23:00"
  default     = "23:00"
}

variable "retention_daily_count" {
  type        = number
  description = "How many daily recovery points to keep."
  default     = 7
}

variable "retention_weekly_count" {
  type        = number
  description = "How many weekly recovery points to keep."
  default     = 4
}

variable "retention_weekly_weekdays" {
  type        = list(string)
  description = "Which weekdays are used for weekly retention points."
  default     = ["Sunday"]
}

# -------------------------
# Optional: protect a VM with this policy
# -------------------------

variable "enable_vm_protection" {
  type        = bool
  description = "If true, enables Azure Backup protection for the VM specified by source_vm_id."
  default     = false
}

variable "source_vm_id" {
  type        = string
  description = "Azure Resource ID of the VM to protect (required if enable_vm_protection=true)."
  default     = ""

  validation {
    condition     = (!var.enable_vm_protection) || (trim(var.source_vm_id) != "")
    error_message = "source_vm_id must be set when enable_vm_protection is true."
  }
}
