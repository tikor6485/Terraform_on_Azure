# AZ-104 / 05 - Linux VM

Creates a Linux VM and attaches it to an existing NIC.

This folder reuses:
- Resource Group created by `AZ-104/01-resource-group`
- NIC / NSG / Public IP created by `AZ-104/04-network-stack`

Optionally, it also adds an inbound SSH allow rule (22) to the existing subnet-level NSG.

## Prerequisites
- Run `AZ-104/01-resource-group` (apply)
- Run `AZ-104/04-network-stack` (apply)
- Azure CLI logged in: `az login`
- Set subscription context (recommended):
  - `az account set --subscription <SUBSCRIPTION_ID>`
  - `export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"`

## Prepare inputs

### Backend
1) Copy backend template:
- `cp backend.hcl.example backend.hcl` (edit values, especially `key`)

2) Init:
- `terraform init -backend-config=backend.hcl -reconfigure`

### Dependencies from previous stacks
Example:
- `export TF_VAR_resource_group_name="$(cd ../01-resource-group && terraform output -raw resource_group_name)"`
- `export TF_VAR_nic_name="$(cd ../04-network-stack && terraform output -raw nic_name)"`
- `export TF_VAR_nsg_name="$(cd ../04-network-stack && terraform output -raw nsg_name)"`
- `export TF_VAR_public_ip_name="$(cd ../04-network-stack && terraform output -raw public_ip_name)"`

### SSH key
Recommended (no secrets in tfvars):
- `export TF_VAR_admin_ssh_public_key="$(cat ~/.ssh/id_ed25519.pub)"`

## cloud-init (optional)
- Copy: `cp cloud-init.yaml.example cloud-init.yaml`
- Edit as needed

## Run
- `terraform fmt`
- `terraform validate`
- `terraform plan`
- `terraform apply`

## Verify
- `terraform output public_ip_address`
- `terraform output ssh_command`

## Clean up
- `terraform destroy`
