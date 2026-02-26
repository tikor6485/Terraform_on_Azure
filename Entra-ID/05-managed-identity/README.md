# Entra-ID/05-managed-identity

This stack creates a **User Assigned Managed Identity (UAMI)** in Azure and assigns it a built-in RBAC role at the **Resource Group** scope.

## What this creates
- `azurerm_user_assigned_identity` (UAMI) in the target resource group
- `azurerm_role_assignment` to grant the identity access to the resource group

## Why this matters
Managed identities provide an Azure-native identity for workloads to authenticate to Azure services **without storing secrets** (no client secret/password to rotate).

## Prerequisites
- Azure CLI logged in: `az login`
- Access to the backend storage account used for Terraform remote state
- Target Resource Group exists (example: `az-104-dev-rg`)

## Usage

```bash
cd ~/Desktop/Terraform_On_Azure/Entra-ID/05-managed-identity

cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl -reconfigure

cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars if needed

terraform fmt
terraform validate
terraform plan
terraform apply

# Entra-ID/05 - App Registrations

This stack creates:
- An Entra ID **App Registration** (`azuread_application`)
- An **Enterprise Application** / **Service Principal** (`azuread_service_principal`)
- Optionally, a **client secret** (`azuread_application_password`)

## Why this matters
App registrations are how applications integrate with Entra ID:
- OAuth / OpenID Connect authentication
- Service-to-service access (client credentials)
- Identity foundation for automations and CI/CD

## Prerequisites
- Azure CLI installed
- Signed in:
  az login


## Backend
Copy example backend config:
- cp backend.hcl.example backend.hcl



## Run
# 1) Create a local backend config file from the example (DO NOT commit backend.hcl)
cp backend.hcl.example backend.hcl

# 2) Initialize Terraform using the backend config (remote state in Azure Storage)
terraform init -backend-config=backend.hcl -reconfigure

# 3) Provide required input variables (Resource Group name) for this stack
# NOTE: The variable name must be TF_VAR_resource_group_name (no typos).
export TF_VAR_resource_group_name="az-104-dev-rg"

# Optional sanity checks
terraform fmt
terraform validate

# Plan & apply
terraform plan
terraform apply


## Outputs
- client_id is safe to share.
- client_secret_value is sensitive and will not be printed by Terraform.
To fetch it (still be careful), you can run:
- terraform output -raw client_secret_value

## Notes
- The secret value is stored in Terraform state (remote backend). Protect access to your state container.
- Secret expiration uses a timestamp. ignore_changes is set to avoid perpetual diffs.

## Clean up
- `terraform destroy`

## Git hygiene
Do NOT commit:
- `backend.hcl`
- `.terraform/`
- `terraform.tfstate*`

Keep:
- `backend.hcl.example`
- `.terraform.lock.hcl`

