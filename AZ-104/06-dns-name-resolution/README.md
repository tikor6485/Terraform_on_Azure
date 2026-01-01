# AZ-104 / 06 - DNS Name Resolution (Private DNS Zone)

Creates a Private DNS Zone and links it to an existing VNet, enabling private name resolution inside Azure.

## Reuses
- Resource Group created by `AZ-104/01-resource-group`
- Virtual Network created by `AZ-104/03-virtual-network`

## What it creates
- Private DNS Zone
- VNet Link (optionally with auto-registration)
- Optional test A record

## Run
1) Backend config:
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
