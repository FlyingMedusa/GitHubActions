locals {
  location        = "francecentral"
  name-core       = "ghactionstryout"
  suffix          = "001"
  tenant_id       = "73689ee1-b42f-4e25-a5f6-66d1f29bc092" # UAM
  subscription_id = "ef85463b-ad7a-4e85-986f-42e0736b253c"
}

module "management" {
  source    = "./infra"
  providers = { azurerm = azurerm }

  location        = local.location
  name-core       = local.name-core
  suffix          = local.suffix
  tenant_id       = local.tenant_id
  subscription_id = local.subscription_id
  github_pat      = var.GITHUB_PAT
}
