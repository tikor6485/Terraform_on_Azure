# AZ-104 / 01 - Resource Group

This project creates a single Azure Resource Group with consistent naming and tags.

## Prerequisites
- Azure CLI logged in (`az login`)
- Terraform installed
- Remote state bootstrap already applied (Storage Account + container for state)

## Configure remote state
1) Copy the example and edit the key to be unique for this project:
- Copy `backend.hcl.example` to `backend.hcl`
- Set `key` to something like: `az-104/01-resource-group/dev.tfstate`

2) Initialize with backend config:
- `terraform init -backend-config=backend.hcl`

## Run
- `terraform fmt`
- `terraform validate`
- `terraform plan`
- `terraform apply`

## Destroy
- `terraform destroy`
