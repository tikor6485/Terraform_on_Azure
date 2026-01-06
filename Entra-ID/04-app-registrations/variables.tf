# -------------------------
# Naming
# -------------------------

variable "project" {
  type        = string
  description = "Project identifier used in naming."
  default     = "entra-id"
}

variable "environment" {
  type        = string
  description = "Environment label."
  default     = "lab"
}

# -------------------------
# App registration settings
# -------------------------

variable "app_display_name" {
  type        = string
  description = "Display name for the App Registration."
  default     = "entra-id-lab-app"
}

variable "sign_in_audience" {
  type        = string
  description = "Who can sign in to the application. Common values: AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount."
  default     = "AzureADMyOrg"
}

variable "owners_object_ids" {
  type        = list(string)
  description = "Optional list of owner object IDs for the application and service principal."
  default     = []
}

# -------------------------
# Client secret (optional)
# -------------------------

variable "create_client_secret" {
  type        = bool
  description = "If true, create a client secret for the application."
  default     = true
}

variable "client_secret_display_name" {
  type        = string
  description = "Display name for the client secret."
  default     = "terraform-generated"
}

variable "client_secret_validity_hours" {
  type        = number
  description = "Client secret validity in hours."
  default     = 24 * 30 # 30 days
}
