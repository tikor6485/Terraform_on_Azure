# AZ-104 / 03 - Virtual Network

Creates an Azure Virtual Network in an existing Resource Group.

## Prerequisites
- Run AZ-104/01-resource-group first (to create the RG)
- Azure CLI logged in (`az login`)
- Set subscription context:
  - `az account set --subscription <SUBSCRIPTION_ID>`
  - `export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"`

## Run
1) Copy backend template:
- `cp backend.hcl.example backend.hcl` (edit values)

2) Init/Plan/Apply:
- `terraform init -backend-config=backend.hcl -reconfigure`
- `terraform plan`
- `terraform apply`

## Clean up
- `terraform destroy`
