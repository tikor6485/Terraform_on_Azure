variable "subscription_id" {
  description = "Azure subscription id. Recommended: set via TF_VAR_subscription_id. Leave empty to use current Azure CLI context."
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure region for the bootstrap resources."
  type        = string
  default     = "northeurope"
}

variable "environment" {
  description = "Environment tag (e.g., dev/test/prod)."
  type        = string
  default     = "dev"
}

variable "resource_prefix" {
  description = "Prefix for resource names. Must start with tfstate- per naming rules."
  type        = string
  default     = "tfstate-demo"

  validation {
    condition     = startswith(var.resource_prefix, "tfstate-")
    error_message = "resource_prefix must start with \"tfstate-\" (example: tfstate-demo)."
  }
}

variable "name_suffix" {
  description = "Optional suffix to help make names globally unique (recommended). Only lowercase letters and digits are recommended."
  type        = string
  default     = ""
}

variable "container_name" {
  description = "Blob container name for remote state."
  type        = string
  default     = "tfstate"
}

variable "principal_ids" {
  description = "Additional Azure AD principal object IDs to grant Storage Blob Data Contributor on the state container (in addition to the current caller)."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}
