locals {
  location        = "francecentral"
  name-core       = "ghactionstryout"
  suffix          = "001"
  tenant_id       = "075ddcce-4e47-4d33-843f-c6b7fbc0ba52"
  subscription_id = "ac10c819-2836-4539-a08d-cf5c42a71d7a"
}

module "management" {
  source    = "./infra"
  providers = { azurerm = azurerm }

  location        = local.location
  name-core       = local.name-core
  suffix          = local.suffix
  tenant_id       = local.tenant_id
  subscription_id = local.subscription_id
}
