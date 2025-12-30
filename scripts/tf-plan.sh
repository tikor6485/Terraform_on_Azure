#!/usr/bin/env bash
# =========================================================
# tf-plan.sh
# Purpose:
# - Run `terraform init` + `terraform plan` for ONE directory.
#
# Behavior:
# - If the directory contains backend.hcl, it will be used automatically.
# - If backend.hcl does not exist, init runs with -backend=false.
#
# Why this approach:
# - backend.hcl often contains per-user/per-environment settings.
# - We do not commit backend.hcl to Git.
# =========================================================

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <working_directory>"
  echo "Example: $0 00-foundation/01-remote-state-azure-storage/bootstrap"
  exit 1
fi

WD="$1"

if [ ! -d "$WD" ]; then
  echo "Error: directory not found: $WD"
  exit 1
fi

echo "==> Terraform init: $WD"
if [ -f "$WD/backend.hcl" ]; then
  terraform -chdir="$WD" init -backend-config="backend.hcl" -input=false
else
  terraform -chdir="$WD" init -backend=false -input=false
fi

echo "==> Terraform plan: $WD"
terraform -chdir="$WD" plan
