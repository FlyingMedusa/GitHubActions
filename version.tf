terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.20"
    }
  }

  backend "azurerm" {
    storage_account_name = "csb10030000ad39d9a7"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    use_azuread_auth     = true
    tenant_id            = "73689ee1-b42f-4e25-a5f6-66d1f29bc092" # UAM
    subscription_id      = "ef85463b-ad7a-4e85-986f-42e0736b253c" # Azure for Students
  }
}
