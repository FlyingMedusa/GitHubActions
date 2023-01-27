provider "azurerm" {
  features {}
  alias           = "main"
  subscription_id = var.subscription_id
}
