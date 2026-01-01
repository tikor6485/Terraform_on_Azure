# Variables for the DNS name resolution stack.
# This stack creates a Private DNS Zone and links it to an existing VNet.

# -------------------------
# Core naming + tagging inputs
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
  description = "Azure region (kept for consistency across stacks; should match RG/VNet region)."
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
# Dependencies (from previous stacks)
# -------------------------

variable "resource_group_name" {
  type        = string
  description = "Existing Resource Group name to reuse (created by AZ-104/01-resource-group)."
}

variable "vnet_name" {
  type        = string
  description = "Existing VNet name to link (created by AZ-104/03-virtual-network)."
}

# -------------------------
# DNS inputs
# -------------------------

variable "private_dns_zone_name" {
  type        = string
  description = "Optional override for Private DNS zone name. If empty, defaults to <name_prefix>.internal."
  default     = ""
}

variable "registration_enabled" {
  type        = bool
  description = "Whether auto-registration is enabled on the VNet link."
  default     = false
}

variable "test_a_record_name" {
  type        = string
  description = "Optional test A record name. If empty, no record is created."
  default     = ""
}

variable "test_a_record_ip" {
  type        = string
  description = "Optional test A record IP. If empty, no record is created."
  default     = ""
}
