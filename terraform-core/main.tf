locals {
  rg_name        = "rg-martha-main-001"
  storage_name   = "st${var.name-core}${var.suffix}"
  container_name = "tfstate"
}

#------------------------------------------------------------------------------
# Resource Group
#------------------------------------------------------------------------------

resource "azurerm_resource_group" "core" {
  provider = azurerm
  name     = local.rg_name
  location = var.location

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    environment = var.environment
  }
}

#------------------------------------------------------------------------------
# Storage account
#------------------------------------------------------------------------------

resource "azurerm_storage_account" "core" {
  provider                 = azurerm
  name                     = local.storage_name
  resource_group_name      = azurerm_resource_group.core.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_container" "core" {
  depends_on           = [azurerm_storage_account.core]
  name                 = local.container_name
  storage_account_name = azurerm_storage_account.core.name
}
