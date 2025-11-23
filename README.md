## 🚀 Project Overview

This repository contains Terraform code organized for multiple environments (dev, prod), modularized Azure resources, and an Azure DevOps pipeline that runs **TFLint** (Terraform linter) to enforce IaC best practices.

---

## 📁 Repository Structure

```
azure_infra_pipeline/
├── environments/
│   ├── dev/
│   │   ├── .terraform/
│   │   ├── .terraform.lock.hcl
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   ├── terraform.tfstate
│   │   ├── terraform.tfstate.backup
│   │   ├── terraform.tfvars
│   │   └── variable.tf
│   │
│   └── prod/
│       ├── .terraform/
│       ├── .terraform.lock.hcl
│       ├── main.tf
│       ├── provider.tf
│       ├── terraform.tfstate
│       ├── terraform.tfstate.backup
│       ├── terraform.tfvars
│       └── variable.tf
│
├── test/
│   └── (optional test tf files)
│
├── modules/
│   ├── application_security_group/
│   │   ├── main.tf
│   │   ├── variable.tf
│   │   └── outputs.tf
│   ├── azure_bastion/
│   │   ├── main.tf
│   │   ├── variable.tf
│   │   └── outputs.tf
│   ├── azure_bastion_subnet/
│   │   ├── main.tf
│   │   ├── variable.tf
│   │   └── outputs.tf
│   ├── azure_container_registry/
│   │   ├── main.tf
│   │   ├── variable.tf
│   │   └── outputs.tf
│   ├── azure_kubernetes_cluster/
│   │   ├── main.tf
│   │   ├── variable.tf
│   │   └── outputs.tf
│   ├── azure_mssql_server/
│   │   ├── main.tf
│   │   ├── variable.tf
│   │   └── outputs.tf
│   ├── azurem_key_vault/
│   │   ├── main.tf
│   │   ├── variable.tf
│   │   └── outputs.tf
│   ├── azurem_compute/
│   │   ├── main.tf
│   │   ├── variable.tf
│   │   └── outputs.tf
│   └── azurem_mssql_database/
│       ├── main.tf
│       ├── variable.tf
│       └── outputs.tf
│
├── .gitignore
├── README.md  <-- this file
└── azure-pipelines.yml
```

---

## 🔧 Quickstart

1. Clone the repo:

```bash
git clone <your-repo-url>
cd azure_infra_pipeline
```

2. Prepare environment-specific variables (do NOT commit secrets):

```bash
cp environments/dev/terraform.tfvars.example environments/dev/terraform.tfvars
# edit values
```

3. Initialize Terraform inside an environment folder (example: dev):

```bash
cd environments/dev
terraform init
terraform plan -var-file=terraform.tfvars
```

---

## 🧩 Azure DevOps Pipeline (overview)

Pipeline (`azure-pipelines.yml`) performs:

* Install TFLint
* `tflint --init`
* Run `tflint --format=sarif > tflint-results.sarif`
* Publish `tflint-results.sarif` as build artifact

Place `azure-pipelines.yml` at repo root. Configure pipeline in Azure DevOps to point to this YAML.

---

## ⚙️ .tflint.hcl (recommended)

Sample configuration (place at repo root or inside `terraform/` folders):

```hcl
plugin "azurerm" {
  enabled = true
  version = "0.21.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

rule "terraform_required_version" {
  enabled = true
}
```

---

## ✅ Best Practices

* Keep state files remote (azurerm backend) for team collaboration
* Do NOT commit sensitive tfvars or state files to git
* Use modules to encapsulate resources
* Run TFLint + Terraform Validate + tfsec in CI
* Protect `main` branch and enforce PR reviews

---

## 🛠️ How to add a new module

1. Create folder under `modules/` with `main.tf`, `variable.tf`, `outputs.tf`.
2. Call module from environment `main.tf`:

```hcl
module "vnet" {
  source = "../modules/vnet"
  # pass variables
}
```

---

## 🧪 Testing & Local Development

* Use `terraform fmt` and `terraform validate` locally
* Use `tflint --init` then `tflint` inside target folder

---

## 📎 Useful Commands (quick reference)

* `terraform init`  `terraform plan`  `terraform apply`
* `tflint --init`  `tflint --format=sarif > tflint-results.sarif`

---

## 📬 Contributing

Raise issues or PRs. Keep changes modular and add tests where possible.

---

## 📄 License

MIT
