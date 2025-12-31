# -------------------------
# Core naming + tagging inputs (aligned across all AZ-104 folders)
# -------------------------

variable "project" {
  type        = string
  description = "Project identifier used in naming and tagging (e.g., az-104)."
  default     = "az-104"
}

variable "environment" {
  type        = string
  description = "Environment label (e.g., dev, test, prod)."
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Azure region for resources in this folder (must match RG/VNet location)."
  default     = "northeurope"
}

variable "owner" {
  type        = string
  description = "Owner tag (team/person)."
  default     = ""
}

variable "cost_center" {
  type        = string
  description = "Cost center tag."
  default     = ""
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to merge into the standard tag set."
  default     = {}
}

# -------------------------
# Dependencies
# -------------------------

variable "resource_group_name" {
  type        = string
  description = "Existing Resource Group name to reuse (created by AZ-104/01-resource-group)."
}

variable "vnet_name" {
  type        = string
  description = "Existing Virtual Network name to reuse (created by AZ-104/03-virtual-network)."
}

# -------------------------
# Network inputs
# -------------------------

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Subnet CIDR prefixes."
  default     = ["10.10.1.0/24"]
}
