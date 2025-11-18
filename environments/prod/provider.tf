terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }
backend "azurerm" {
  resource_group_name = "pipeline_rg"
  storage_account_name = "pipelinestg01"
  container_name = "tfprodcontainer"
  key = "prod.terraform.tfstate"
}
}

provider "azurerm" {
  features {}
  subscription_id = "6dbc33a2-5da4-4090-8ac2-b8dde7d2a834"
}
