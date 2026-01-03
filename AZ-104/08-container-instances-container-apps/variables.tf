// Input variables for this stack.
// Naming/tagging are consistent with previous stacks.

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
  description = "Azure region for the Container Group (ideally same region as the Resource Group)."
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

# -------------------------
# Container Instances settings
# -------------------------

variable "container_group_name" {
  type        = string
  description = "Optional override for the Container Group name. If empty, defaults to <name_prefix>-aci."
  default     = ""
}

variable "container_image" {
  type        = string
  description = "Public container image to deploy. Default uses a Microsoft Container Registry image known to work with ACI."
  default     = "mcr.microsoft.com/azuredocs/aci-helloworld"
}

variable "container_cpu" {
  type        = number
  description = "CPU cores allocated to the container."
  default     = 0.5
}

variable "container_memory" {
  type        = number
  description = "Memory in GB allocated to the container."
  default     = 1
}

variable "container_port" {
  type        = number
  description = "Exposed TCP port for the container."
  default     = 80
}

variable "dns_name_label" {
  type        = string
  description = "Optional DNS name label for public FQDN. If empty, no FQDN is created (use public IP instead)."
  default     = ""
}

variable "restart_policy" {
  type        = string
  description = "Restart policy for the container group: Always, OnFailure, or Never."
  default     = "Always"

  validation {
    condition     = contains(["Always", "OnFailure", "Never"], var.restart_policy)
    error_message = "restart_policy must be one of: Always, OnFailure, Never."
  }
}
