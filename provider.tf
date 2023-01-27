provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "github" {
  owner = var.GITHUB_OWNER
  token = var.GITHUB_PAT
}
