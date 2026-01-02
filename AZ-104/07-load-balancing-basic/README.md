# AZ-104 / 07 - Load Balancing (Basic)

Creates a basic Azure Load Balancer with a Public IP and a backend pool, suitable for AZ-104 lab scenarios.

## Reuses
- Resource Group created by `AZ-104/01-resource-group`
- Optional: NICs from VMs created by `AZ-104/05-linux-vm` (or any other VM stack)

## What it creates
- Public IP (Static)
- Load Balancer (Standard by default)
- Backend Address Pool
- Health Probe
- Load Balancer Rule
- Optional NIC-to-backend-pool associations

## Run
1) Backend config:
- `cp backend.hcl.example backend.hcl` (edit values, especially `key`)

2) Init:
- `terraform init -backend-config=backend.hcl -reconfigure`

3) Provide dependencies (example):
- `export TF_VAR_resource_group_name="$(cd ../01-resource-group && terraform output -raw resource_group_name)"`

4) Optional: attach backend NICs
- Find NIC ID + ip config name:
  - `az network nic show -g <RG> -n <NIC_NAME> --query "{id:id, ipConfig:ipConfigurations[0].name}" -o yaml`
- Then set `backend_nics` (example):
  - `export TF_VAR_backend_nics='[{"nic_id":"<NIC_ID>","ip_configuration_name":"ipconfig1"}]'`

5) Plan/Apply:
- `terraform plan`
- `terraform apply`

## Clean up
- `terraform destroy`
