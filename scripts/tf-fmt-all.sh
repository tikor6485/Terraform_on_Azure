#!/usr/bin/env bash
# =========================================================
# tf-fmt-all.sh
# Purpose:
# - Run `terraform fmt` across the entire repository.
# - Ensures consistent formatting and reduces noisy diffs.
# =========================================================

set -euo pipefail

# Run recursive formatting from repo root.
terraform fmt -recursive
echo "OK: terraform fmt completed (recursive)."
