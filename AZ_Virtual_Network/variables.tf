variable "subscription_id" {
  description = "Azure Subscription ID. Leave empty to use Azure CLI context, or set TF_VAR_subscription_id."
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure region where resources will be created."
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name used in resource naming and tagging (e.g., dev, test, prod)."
  type        = string
  default     = "dev"
}

variable "resource_prefix" {
  description = "Prefix used for resource names (keep it short and lowercase)."
  type        = string
  default     = "tf-demo"
}

variable "vnet_address_space" {
  description = "Address space (CIDR blocks) for the Virtual Network."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}
