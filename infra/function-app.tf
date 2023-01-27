resource "azurerm_windows_function_app" "main" {
  name                = "func-${var.environment}-${var.suffix}"
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
