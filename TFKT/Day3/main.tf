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




resource "azurerm_resource_group" "myRG" {
  name     = "testRGfromIAC-day3"
  location = "eastus"
  tags = {
    "purpose" = "demo"
    "region"  = "eastus"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_account" "myStorage" {
  name                     = "tfkstorage1234"
  resource_group_name      = azurerm_resource_group.myRG.name
  location                 = azurerm_resource_group.myRG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_virtual_network" "myVNet" {
  name                = "tfk-day3-vnet"
  location            = azurerm_resource_group.myRG.location
  resource_group_name = azurerm_resource_group.myRG.name
  address_space       = ["10.0.0.0/16"]
}



module "storage" {
  source = "./modules/storage"

  storage_account_name = "tfday4import12345"
  resource_group_name  = "rg01"
  location             = "eastus"
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