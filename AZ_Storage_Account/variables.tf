variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID. If TF_VAR_subscription_id is set in your shell, you can leave this empty."
  default     = ""
}

variable "location" {
  type        = string
  description = "Azure region for the demo resources."
  default     = "eastus"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix used for naming."
  default     = "tf-demo"
}

variable "environment" {
  type        = string
  description = "Environment label used in naming and tags."
  default     = "dev"
}

variable "container_name" {
  type        = string
  description = "Blob container name (lowercase only)."
  default     = "tfcontainer"
}
