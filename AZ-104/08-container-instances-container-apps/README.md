# AZ-104 / 08 - Container Instances (ACI) - Basic Public Container

Creates a simple Azure Container Instances (ACI) Container Group with a public IP (and optional DNS label) for quick testing.

## Reuses
- Resource Group created by `AZ-104/01-resource-group`

## What it creates
- Azure Container Group (ACI) running a single container
- Public IP address
- Optional public FQDN (if `dns_name_label` is set)

## Why this image?
By default this stack uses a Microsoft Container Registry (MCR) public image:
- `mcr.microsoft.com/azuredocs/aci-helloworld`

This avoids intermittent Docker Hub issues (rate limits / temporary registry errors) that can break ACI deployments.

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

## Test

- If you set `dns_name_label`, Terraform will output `aci_fqdn` and you can test:
  - `curl "http://$(terraform output -raw aci_fqdn)"`

- Otherwise test using the public IP:
  - `curl "http://$(terraform output -raw aci_ip_address)"`

## Clean up
- `terraform destroy`

## Notes
- If you enable `dns_name_label`, ensure it is globally unique (within Azure public DNS labels) to avoid conflicts.
