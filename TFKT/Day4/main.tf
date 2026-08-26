terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

import {
  to = azurerm_storage_account.imported
  id = "/subscriptions/db032ea8-62d9-47ad-8714-22e7c42714f3/resourceGroups/rg01/providers/Microsoft.Storage/storageAccounts/tfday4import12345"
}

resource "azurerm_storage_account" "imported" {
  name                     = "YOUR_STORAGE_ACCOUNT_NAME"
  resource_group_name      = "YOUR_RESOURCE_GROUP"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}



resource "azurerm_resource_group" "myRG" {
  name = "testRGfromIAC-day3"
  location = "eastus"
  tags = {
    "purpose" = "demo"
    "region"  = "eastus"
  }
}

resource "azurerm_virtual_network" "myVNet" {
  name                = "tfk-day3-vnet"
  location            = azurerm_resource_group.myRG.location
  resource_group_name = azurerm_resource_group.myRG.name
  address_space       = ["10.0.0.0/16"]
}

module "dev" {
  source = "./modules/network"

  resource_group_name = azurerm_resource_group.myRG.name
  vnet_name           = azurerm_virtual_network.myVNet.name
  location            = azurerm_resource_group.myRG.location
  subnet_name         = "dev-subnet"
  address_prefix      = "10.0.1.0/24"
}

module "test" {
  source = "./modules/network"

  resource_group_name = azurerm_resource_group.myRG.name
  vnet_name           = azurerm_virtual_network.myVNet.name
  location            = azurerm_resource_group.myRG.location
  subnet_name         = "test-subnet"
  address_prefix      = "10.0.2.0/24"
}