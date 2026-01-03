# AZ-104 / 10 - Backup & Recovery (Recovery Services Vault + VM Backup Policy)

Creates an Azure Recovery Services Vault and a VM Backup Policy.  
Optionally, it can enable Azure Backup protection for an existing Azure VM (if you provide the VM ID).

## Reuses
- Resource Group created by `AZ-104/01-resource-group`
- (Optional) A VM created by `AZ-104/05-linux-vm` (or any existing Azure VM)

## What it creates
- Recovery Services Vault
- VM Backup Policy (daily backup + retention)
- (Optional) Backup protection for a specific VM

## Run
1) Backend config:
- `cp backend.hcl.example backend.hcl` (edit values, especially `key`)

2) Init:
- `terraform init -backend-config=backend.hcl -reconfigure`

3) Provide dependencies (example):
- `export TF_VAR_resource_group_name="$(cd ../01-resource-group && terraform output -raw resource_group_name)"`

4) Plan/Apply:
- `terraform plan`
- `terraform apply`

## Optional: protect an existing VM
If you want this stack to actually enable backup on a VM, you must pass the VM resource ID:
- `export TF_VAR_enable_vm_protection=true`
- `export TF_VAR_source_vm_id="/subscriptions/<SUB_ID>/resourceGroups/<RG>/providers/Microsoft.Compute/virtualMachines/<VM_NAME>"`

Tip: If your VM was created by `AZ-104/05-linux-vm`, you can usually get the ID from that stack outputs:
- `export TF_VAR_source_vm_id="$(cd ../05-linux-vm && terraform output -raw vm_id)"`

## Clean up
- `terraform destroy`
- Remove local-only files:
  - `rm -f backend.hcl`
  - `rm -rf .terraform`
  - (No local tfstate should exist if remote backend is used)
