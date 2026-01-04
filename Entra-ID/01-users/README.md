# Entra ID / 01 - Users (Terraform)

Creates Microsoft Entra ID (Azure AD) users using the `azuread` Terraform provider.  
By default, this stack is safe: it creates **no users** unless you provide `var.users`.

## What it creates
- Entra ID Users (`azuread_user`) for each entry in `var.users`

## Prerequisites
- Azure CLI logged in:
  - `az login`
- Sufficient Entra permissions to create users (e.g., User Administrator or Global Administrator)
- Remote state backend already prepared (Azure Storage Account + container)

## Run

1) Backend config:
- `cp backend.hcl.example backend.hcl` (edit values, especially `key`)

2) Init:
- `terraform init -backend-config=backend.hcl -reconfigure`

3) Provide inputs (choose one):
- Option A (recommended): create a local-only `terraform.tfvars` (do not commit real passwords)
  - `cp terraform.tfvars.example terraform.tfvars`
  - Edit `terraform.tfvars` with your tenant domain and a strong password
- Option B: environment variables (example)
  - `export TF_VAR_users='[{"user_principal_name":"az104.user1@YOURTENANT.onmicrosoft.com","display_name":"AZ-104 Demo User 1","password":"<STRONG_PASSWORD>","force_change_password_next_sign_in":true,"account_enabled":true}]'`

4) Plan/Apply:
- `terraform plan`
- `terraform apply`

## Verify
- `terraform output -json created_user_ids`

## Clean up
- `terraform destroy`

## Notes
- Passwords are sensitive. Do not commit real passwords to Git.
- User principal names must be in your tenant domain (e.g., `*.onmicrosoft.com` or a verified custom domain).
