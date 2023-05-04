output "tfstate_resource_group_name" {
  value = azurerm_resource_group.core.name
}

output "tfstate_storage_account" {
  value = azurerm_storage_account.core.name
}

output "tfstate_storage_container_core" {
  value = azurerm_storage_container.core.name
}
