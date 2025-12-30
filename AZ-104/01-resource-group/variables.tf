variable "project" {
  description = "Project identifier used for naming and tagging (e.g., terraform-on-azure, az104)."
  type        = string
  default     = "az-104"
}

variable "environment" {
  description = "Environment name (e.g., dev/test/prod)."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "northeurope"
}

variable "owner" {
  description = "Owner tag (team/person)."
  type        = string
  default     = ""
}

variable "cost_center" {
  description = "Cost center tag (billing reference)."
  type        = string
  default     = ""
}

variable "additional_tags" {
  description = "Extra tags to merge into the standard tag set."
  type        = map(string)
  default     = {}
}

variable "resource_group_name_override" {
  description = "Optional: override the generated resource group name."
  type        = string
  default     = ""
}
