# Azure subscription to use (set via TF_VAR_subscription_id or a local tfvars file).
variable "subscription_id" {
  type        = string
  description = "Azure subscription ID used by the AzureRM provider."
  default     = ""
}

# Optional Service Principal fields (useful for CI/CD; leave empty for Azure CLI auth).
variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID (optional)."
  default     = ""
}

variable "client_id" {
  type        = string
  description = "Service Principal client/application ID (optional)."
  default     = ""
}

variable "client_secret" {
  type        = string
  description = "Service Principal client secret (optional)."
  default     = ""
  sensitive   = true
}

# Default region for demo resources.
variable "location" {
  type        = string
  description = "Azure region for this demo."
  default     = "eastus"
}

# Name prefix used to build resource names.
variable "resource_prefix" {
  type        = string
  description = "Prefix used in naming demo resources."
  default     = "tf-demo"
}

# Environment label used in names/tags (dev/test/prod).
variable "environment" {
  type        = string
  description = "Environment name used in naming and tagging."
  default     = "dev"
}

# Blob container name (must be lowercase).
variable "container_name" {
  type        = string
  description = "Name of the blob container to create."
  default     = "tfcontainer"
}
