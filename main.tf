data "azurerm_client_config" "current" {}

module "core" {
  source    = "./terraform-core"
  providers = { azurerm = azurerm }

  location        = var.location
  name-core       = var.name-core-terraform
  suffix          = var.suffix
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  environment     = "terraform"
}

module "analytics" {
  source    = "./analytics"
  providers = { azurerm = azurerm }

  location        = var.location
  name-core       = var.name-core-analytics
  suffix          = var.suffix
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  environment     = "dev-analytics"
}
