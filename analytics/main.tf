locals {
  rg_name           = "rg-martha-analytics-001"
  storage_name      = "st${var.name-core}${var.suffix}"
  service_plan_name = "sp-${var.name-core}-${var.suffix}"
  function_app_name = "func-${var.name-core}-${var.suffix}"
  app_insights_name = "appin-${var.name-core}-${var.suffix}"
}

#------------------------------------------------------------------------------
# Resource Group
#------------------------------------------------------------------------------

resource "azurerm_resource_group" "analytics" {
  provider = azurerm
  name     = local.rg_name
  location = var.location

  tags = {
    environment = var.environment
  }
}

#------------------------------------------------------------------------------
# Storage account
#------------------------------------------------------------------------------

resource "azurerm_storage_account" "analytics" {
  provider                 = azurerm
  name                     = local.storage_name
  resource_group_name      = azurerm_resource_group.analytics.name
  location                 = azurerm_resource_group.analytics.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  tags = {
    environment = var.environment
  }
}

#------------------------------------------------------------------------------
# Service plan
#------------------------------------------------------------------------------

resource "azurerm_service_plan" "analytics" {
  name                = local.service_plan_name
  resource_group_name = azurerm_resource_group.analytics.name
  location            = azurerm_resource_group.analytics.location
  os_type             = "Linux"
  sku_name            = "Y1"

  tags = {
    environment = var.environment
  }
}

#------------------------------------------------------------------------------
# Application insights
#------------------------------------------------------------------------------

resource "azurerm_application_insights" "analytics" {
  name                = local.app_insights_name
  location            = azurerm_resource_group.analytics.location
  resource_group_name = azurerm_resource_group.analytics.name
  application_type    = "web"
}

#------------------------------------------------------------------------------
# Function App
#------------------------------------------------------------------------------

resource "azurerm_linux_function_app" "analytics" {
  name                = local.function_app_name
  resource_group_name = azurerm_resource_group.analytics.name
  location            = azurerm_resource_group.analytics.location

  storage_account_name       = azurerm_storage_account.analytics.name
  storage_account_access_key = azurerm_storage_account.analytics.primary_access_key
  service_plan_id            = azurerm_service_plan.analytics.id

  site_config {
    application_stack {
      node_version = "18"
    }
  }

  app_settings = {
    https_only                            = true
    FUNCTIONS_WORKER_RUNTIME              = "node"
    FUNCTION_APP_EDIT_MODE                = "readonly"
    FUNCTIONS_WORKER_RUNTIME              = "node"
    WEBSITE_CONTENTSHARE                  = azurerm_storage_account.analytics.name
    AZURE_SUBSCRIPTION_ID                 = "/subscriptions/${var.subscription_id}"
    TENANT_ID                             = var.tenant_id
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.analytics.connection_string
    APPINSIGHTS_INSTRUMENTATIONKEY        = azurerm_application_insights.analytics.instrumentation_key
    AZURE_LOG_LEVEL                       = "verbose"
  }

  functions_extension_version = "~4"

  tags = {
    environment = var.environment
  }
}
