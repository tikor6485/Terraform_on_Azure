variable "subscription_id" {
  description = "Azure subscription id. Recommended: set via TF_VAR_subscription_id or rely on Azure CLI context."
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure region for resources in this project."
  type        = string
  default     = "northeurope"
}

variable "environment" {
  description = "Environment name (dev/test/prod)."
  type        = string
  default     = "dev"
}

variable "resource_prefix" {
  description = "Prefix used in resource names."
  type        = string
  default     = "tf-demo"
}

variable "tags" {
  description = "Common tags to apply to resources."
  type        = map(string)
  default = {
    managed_by = "terraform"
  }
}
