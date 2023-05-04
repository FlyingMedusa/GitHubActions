terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.20"
    }
  }

  backend "local" {
    path = ".terraform\terraform.tfstate"
  }
}
