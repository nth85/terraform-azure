terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.69"
    }
  }
  #beckend for push file terraform.tfstate to azure cloud# create storage first
  # backend "azurerm" {
  #   resource_group_name  = "nth-terraform-state"
  #   storage_account_name = "stterraforstatenth"
  #   container_name       = "tfstate"
  #   key                  = "nth.terraform.tfstate" # name file will save on Cloud
  # }
}

provider "azurerm" {
  features {}
}