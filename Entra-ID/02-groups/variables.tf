# -------------------------
# Core naming inputs
# -------------------------

variable "project" {
  type        = string
  description = "Project identifier used for naming conventions."
  default     = "entra-id"
}

variable "environment" {
  type        = string
  description = "Environment label (e.g., dev, test, prod)."
  default     = "dev"
}

# -------------------------
# Groups definition
# -------------------------

variable "groups" {
  description = <<EOT
Map of groups to create.

Example:
groups = {
  "ops" = {
    display_name       = "Lab - Ops"
    description        = "Operations team (lab)."
    owners_object_ids  = []
    members_object_ids = []
    mail_nickname      = "lab-ops" # optional
  }
}
EOT

  type = map(object({
    display_name       = string
    description        = optional(string)
    owners_object_ids  = optional(list(string))
    members_object_ids = optional(list(string))
    mail_nickname      = optional(string)
  }))

  default = {}

  validation {
    condition = alltrue([
      for k, g in var.groups :
      length(trimspace(g.display_name)) > 1
    ])
    error_message = "Each group must have a non-empty display_name."
  }
}
