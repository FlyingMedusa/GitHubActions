terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.54.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.20"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-martha-main-001"
    storage_account_name = "stmarthamain001"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    tenant_id            = "075ddcce-4e47-4d33-843f-c6b7fbc0ba52"
    subscription_id      = "ac10c819-2836-4539-a08d-cf5c42a71d7a" # sub-edu-001
  }
}
