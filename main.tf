module "management" {
  source    = "./infra"
  providers = { azurerm = azurerm }

  location        = var.location
  name-core       = var.name-core
  suffix          = var.suffix
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}
