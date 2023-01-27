terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
}

// Variables
variable "environment" {
  type    = string
  default = ""
}

variable "location" {
  type    = string
  default = ""
}

variable "subscription_id" {
  type    = string
  default = ""
}

variable "suffix" {
  type    = string
  default = ""
}

data "azurerm_client_config" "current" {}

provider "azurerm" {
  subscription_id = var.subscription_id
}

// Resource group

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.environment}"
  location = var.location
}

// Storage account

resource "azurerm_storage_account" "main" {
  name                     = "st${var.environment}${var.suffix}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}
