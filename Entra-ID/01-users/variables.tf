/*
variables.tf
- Defines inputs for naming consistency and the Entra user objects created by this stack.
- Default behavior is safe: no users are created unless you provide var.users.
*/

# -------------------------
# Core naming + tagging inputs (consistency with AZ-104 stacks)
# -------------------------

variable "project" {
  type        = string
  description = "Project identifier used in naming (e.g., az-104)."
  default     = "az-104"
}

variable "environment" {
  type        = string
  description = "Environment label (e.g., dev, test, prod)."
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Azure region (kept for consistency; not used directly in Entra-only resources)."
  default     = "northeurope"
}

variable "owner" {
  type        = string
  description = "Owner tag (team/person). Kept for consistency across the repo."
  default     = ""
}

variable "cost_center" {
  type        = string
  description = "Cost center tag. Kept for consistency across the repo."
  default     = ""
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to merge into a standard tag set. Kept for consistency across the repo."
  default     = {}
}

# -------------------------
# Entra ID users
# -------------------------

variable "users" {
  description = <<EOT
List of Entra ID users to create.

Notes:
- If this list is empty, Terraform will create nothing (safe default).
- Passwords are sensitive. Do not commit real passwords. Prefer environment variables or a non-committed tfvars file.
- UPN must be in your tenant domain (or a verified custom domain).
EOT

  type = list(object({
    user_principal_name                = string
    display_name                       = string
    password                           = string
    force_change_password_next_sign_in = bool
    account_enabled                    = bool
  }))

  default = []

  validation {
    condition = alltrue([
      for u in var.users : (
        length(trimspace(u.user_principal_name)) > 3 &&
        can(regex("@", u.user_principal_name)) &&
        length(trimspace(u.display_name)) > 1 &&
        length(u.password) >= 12
      )
    ])
    error_message = "Each user must have a valid UPN containing '@', a non-empty display_name, and a password with at least 12 characters."
  }
}
