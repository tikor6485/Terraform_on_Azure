# -------------------------
# Core naming inputs
# -------------------------

variable "project" {
  type        = string
  description = "Project identifier used in naming (e.g., entra-id)."
  default     = "entra-id"
}

variable "environment" {
  type        = string
  description = "Environment label for naming (e.g., lab, dev)."
  default     = "lab"
}

# -------------------------
# Conditional Access (MFA) settings
# -------------------------

variable "enable_conditional_access" {
  type        = bool
  description = "If true, create the Conditional Access policy (requires Entra ID P1+ and proper admin role)."
  default     = false
}

variable "policy_state" {
  type        = string
  description = "Conditional Access policy state. Use report-only first if testing."
  default     = "enabledForReportingButNotEnforced"

  validation {
    condition = contains(
      ["enabled", "disabled", "enabledForReportingButNotEnforced"],
      var.policy_state
    )
    error_message = "policy_state must be one of: enabled, disabled, enabledForReportingButNotEnforced."
  }
}

variable "policy_display_name" {
  type        = string
  description = "Display name for the Conditional Access policy. If empty, a deterministic name is used."
  default     = ""
}

variable "included_group_display_names" {
  type        = list(string)
  description = "Entra ID group display names to include in the MFA requirement policy."
  default     = ["Lab - Dev"]
}

variable "excluded_user_upns" {
  type        = list(string)
  description = "Optional list of user UPNs to exclude (e.g., break-glass accounts)."
  default     = []
}
