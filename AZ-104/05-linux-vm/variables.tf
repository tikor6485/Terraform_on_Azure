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
  description = "Azure region for resources in this folder (must match RG/NIC/NSG location)."
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

variable "nic_name" {
  type        = string
  description = "Existing Network Interface name to reuse (created by AZ-104/04-network-stack)."
}

variable "nsg_name" {
  type        = string
  description = "Existing Network Security Group name to reuse (created by AZ-104/04-network-stack)."
}

variable "public_ip_name" {
  type        = string
  description = "Existing Public IP name to reuse (created by AZ-104/04-network-stack)."
}

# -------------------------
# VM inputs
# -------------------------

variable "vm_size" {
  type        = string
  description = "VM size."
  default     = "Standard_D2s_v4"
}

variable "vm_name" {
  type        = string
  description = "Optional override for VM name. If empty, a standard name is used."
  default     = ""
}

variable "admin_username" {
  type        = string
  description = "Admin username for the Linux VM."
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key content for admin login (e.g., cat ~/.ssh/id_ed25519.pub)."
  validation {
    condition     = length(trimspace(var.admin_ssh_public_key)) > 0
    error_message = "admin_ssh_public_key must not be empty."
  }
}

variable "cloud_init_file" {
  type        = string
  description = "Optional cloud-init file path. If the file is missing, custom_data will be null."
  default     = "cloud-init.yaml"
}

# -------------------------
# Optional SSH rule on existing NSG (subnet-level)
# -------------------------

variable "enable_ssh" {
  type        = bool
  description = "Whether to add an inbound SSH allow rule to the existing NSG."
  default     = true
}

variable "ssh_source_cidrs" {
  type        = list(string)
  description = "Allowed source CIDRs for SSH (recommended: your public IP /32)."
  default     = ["0.0.0.0/0"]
}

variable "ssh_rule_priority" {
  type        = number
  description = "NSG rule priority for SSH."
  default     = 100
}
