resource "azurerm_service_plan" "main" {
  name                = "asp-${var.environment}-${var.suffix}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "Y1"
}
