# AZ-104 / 04 - Network Stack

Creates a baseline network stack in an existing Resource Group and Virtual Network:
- Subnet
- Network Security Group (associated to the subnet)
- Public IP (Standard/Static)
- Network Interface (attached to subnet + public IP)

This folder reuses:
- Resource Group created by `AZ-104/01-resource-group`
- Virtual Network created by `AZ-104/03-virtual-network`

## Prerequisites
- Run `AZ-104/01-resource-group` (apply)
- Run `AZ-104/03-virtual-network` (apply)
- Azure CLI logged in: `az login`
- Set subscription context (recommended):
  - `az account set --subscription <SUBSCRIPTION_ID>`
  - `export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"`

## Run
1) Copy backend template:
- `cp backend.hcl.example backend.hcl` (edit values, especially `key`)

2) Init:
- `terraform init -backend-config=backend.hcl -reconfigure`

3) Provide dependencies (example):
- `export TF_VAR_resource_group_name="$(cd ../01-resource-group && terraform output -raw resource_group_name)"`
- `export TF_VAR_vnet_name="$(cd ../03-virtual-network && terraform output -raw vnet_name)"`

4) Plan/Apply:
- `terraform plan`
- `terraform apply`

## Clean up
- `terraform destroy`
