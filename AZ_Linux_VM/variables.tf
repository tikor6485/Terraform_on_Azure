variable "subscription_id" {
  description = "Azure subscription id. Recommended: set via TF_VAR_subscription_id environment variable."
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure region for all resources."
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

variable "vnet_address_space" {
  description = "VNet CIDR list."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Subnet CIDR list."
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "admin_username" {
  description = "Linux VM admin username."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key used for VM login."
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "cloud_init_file" {
  description = "Cloud-init file path. Terraform will send it via custom_data using filebase64()."
  type        = string
  default     = "cloud-init.yaml.example"
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_D2s_v4"
}
