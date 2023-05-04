data "azurerm_client_config" "current" {}

locals {
  rg_name       = "rg-${var.name-core}"
  storage_name  = "st${var.name-core}${var.suffix}"
  asp_name      = "asp-${var.name-core}-${var.suffix}"
  func_app_name = "func-${var.name-core}-${var.suffix}"
}

#------------------------------------------------------------------------------
# Resource Group
#------------------------------------------------------------------------------

resource "azurerm_resource_group" "main" {
  provider = azurerm
  name     = local.rg_name
  location = var.location
}

#------------------------------------------------------------------------------
# Storage account
#------------------------------------------------------------------------------

resource "azurerm_storage_account" "main" {
  provider                 = azurerm
  name                     = local.storage_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

#------------------------------------------------------------------------------
# Service plan
#------------------------------------------------------------------------------

resource "azurerm_service_plan" "main" {
  provider            = azurerm
  name                = local.asp_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "Y1"
}

#------------------------------------------------------------------------------
# Function app
#------------------------------------------------------------------------------

resource "azurerm_windows_function_app" "main" {
  provider            = azurerm
  name                = local.func_app_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location

  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  service_plan_id            = azurerm_service_plan.main.id

  site_config {
    application_stack {
      node_version = "~16"
    }
  }

  app_settings = {
    https_only               = true
    FUNCTIONS_WORKER_RUNTIME = "node"
    FUNCTION_APP_EDIT_MODE   = "readonly"
    FUNCTIONS_WORKER_RUNTIME = "node"
    WEBSITE_CONTENTSHARE     = azurerm_storage_account.main.name
    AZURE_SUBSCRIPTION_ID    = "/subscriptions/${var.subscription_id}"
    TENANT_ID                = data.azurerm_client_config.current.tenant_id
  }
}
