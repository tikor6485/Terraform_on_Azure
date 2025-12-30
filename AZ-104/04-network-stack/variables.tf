variable "subscription_id" {
  type        = string
  description = "Azure subscription id. Recommended: export TF_VAR_subscription_id."
  default     = ""
}

variable "location" {
  type        = string
  description = "Azure region for resources."
  default     = "eastus"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix used in resource names."
  default     = "tf-demo"
}

variable "environment" {
  type        = string
  description = "Environment name used in resource names and tags."
  default     = "dev"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "VNet address space CIDRs."
  default     = ["10.20.0.0/16"]
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Subnet address prefixes CIDRs."
  default     = ["10.20.1.0/24"]
}
