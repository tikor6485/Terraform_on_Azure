variable "subscription_id" {
  type        = string
  default     = ""
  description = "Azure Subscription ID (optional if using Azure CLI auth)"
}

variable "tenant_id" {
  type        = string
  default     = ""
  description = "Azure AD tenant ID (used for Service Principal auth)"
}

variable "client_id" {
  type        = string
  default     = ""
  description = "Service Principal application (client) ID"
}

variable "client_secret" {
  type        = string
  default     = ""
  sensitive   = true
  description = "Service Principal client secret"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure region"
}

variable "resource_prefix" {
  type        = string
  default     = "tf-demo"
  description = "Prefix for resource naming"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment name (dev/stage/prod)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags applied to resources"
}
