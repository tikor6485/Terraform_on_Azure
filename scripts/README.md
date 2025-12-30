# scripts/

Helper scripts for running Terraform consistently across this repository.

Why these scripts exist:
- Many folders are independent Terraform projects.
- Running `init/validate/plan/apply` manually in each directory is repetitive.
- Scripts reduce human error and keep execution consistent.

Usage examples:
- Validate all Terraform directories:
  ./scripts/tf-validate-all.sh

- Format all Terraform directories:
  ./scripts/tf-fmt-all.sh

- Plan a specific directory:
  ./scripts/tf-plan.sh az-104/05-linux-vm

Notes:
- These scripts assume a Unix-like environment (Linux/macOS/WSL).
- They do not embed any credentials.
- Azure authentication is expected to come from your Azure CLI login (az login)
  or from environment variables if you prefer.
