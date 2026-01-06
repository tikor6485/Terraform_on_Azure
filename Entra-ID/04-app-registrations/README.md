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
1) Backend config:
- `cp backend.hcl.example backend.hcl`

2) Init:
- `terraform init -backend-config=backend.hcl -reconfigure`

3) Provide RBAC assignments:
- `cp terraform.tfvars.example terraform.tfvars`
- Edit `terraform.tfvars` as needed.

5) Plan/Apply:
- `terraform plan`
- `terraform apply`

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
