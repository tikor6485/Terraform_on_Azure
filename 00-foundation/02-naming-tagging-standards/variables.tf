variable "project" {
  description = "Project identifier used for naming and tagging (e.g., terraform-on-azure)."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, test, prod)."
  type        = string
}

variable "location" {
  description = "Deployment location/region label used for tagging and optional naming (provider-agnostic)."
  type        = string
}

variable "owner" {
  description = "Owner of the resources (team/person), used for tagging."
  type        = string
}

variable "cost_center" {
  description = "Cost center or billing code, used for tagging."
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to merge into the standard tag set."
  type        = map(string)
  default     = {}
}
