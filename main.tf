data "azurerm_client_config" "current" {}

module "management" {
  source    = "./terraform-core"
  providers = { azurerm = azurerm }

  location        = var.location
  name-core       = var.name-core
  suffix          = var.suffix
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  environment     = var.environment
}
