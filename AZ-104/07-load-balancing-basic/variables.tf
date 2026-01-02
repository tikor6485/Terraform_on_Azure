# ------------------------------------------------------------
# Inputs for AZ-104 / 07-load-balancing-basic
# This stack creates a Public IP + Load Balancer + backend pool +
# health probe + LB rule, and can optionally attach NICs.
# ------------------------------------------------------------

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
  description = "Azure region (should match the Resource Group region)."
  default     = "northeurope"
}

variable "owner" {
  type        = string
  description = "Owner tag (team/person). Leave empty to omit."
  default     = ""
}

variable "cost_center" {
  type        = string
  description = "Cost center tag. Leave empty to omit."
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
# Load Balancer settings
# -------------------------

variable "lb_sku" {
  type        = string
  description = "Load Balancer SKU. Standard recommended."
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Basic"], var.lb_sku)
    error_message = "lb_sku must be either Standard or Basic."
  }
}

variable "public_ip_sku" {
  type        = string
  description = "Public IP SKU. Standard recommended (and required for Standard LB)."
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Basic"], var.public_ip_sku)
    error_message = "public_ip_sku must be either Standard or Basic."
  }
}

variable "frontend_port" {
  type        = number
  description = "Frontend port on the Load Balancer."
  default     = 80
}

variable "backend_port" {
  type        = number
  description = "Backend port on the target VMs."
  default     = 80
}

variable "probe_port" {
  type        = number
  description = "Health probe port."
  default     = 80
}

variable "lb_protocol" {
  type        = string
  description = "Protocol for the LB rule and probe (Tcp or Udp)."
  default     = "Tcp"
  validation {
    condition     = contains(["Tcp", "Udp"], var.lb_protocol)
    error_message = "lb_protocol must be Tcp or Udp."
  }
}

# -------------------------
# Optional: attach NICs to backend pool
# -------------------------
# Provide NIC ID and the IP configuration name (usually 'ipconfig1').
# If empty, LB will be created with an empty backend pool.
variable "backend_nics" {
  type = list(object({
    nic_id                = string
    ip_configuration_name = string
  }))
  description = "Optional list of NIC IP configurations to associate with the LB backend pool."
  default     = []
}
