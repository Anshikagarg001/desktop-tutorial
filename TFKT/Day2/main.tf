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


locals {
  common_tags = {
    location    = var.location
    environment = "dev"
  }
}



/*data "azurerm_virtual_network" "vnet_data"{
  name="vnet-01 "
  resource_group_name = "testRGfromIAC"
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  =  data.azurerm_virtual_network.vnet_data.resource_group_name
  virtual_network_name =  data.azurerm_virtual_network.vnet_data.resource_group_name
  address_prefixes     = ["10.0.1.0/24"]
}
*/





resource "azurerm_resource_group" "myRG" {
  name     = "testRGfromIAC"
  location = var.location
  tags = {
    "purpose" = "demo"
    "region"  = "eastus"
  }
}

resource "azurerm_storage_account" "myStorage" {
  name                     = "tfkday1storage1234"
  resource_group_name      = azurerm_resource_group.myRG.name
  location                 = azurerm_resource_group.myRG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_virtual_network" "myVNet" {
  name                = "tfk-day1-vnet"
  location            = azurerm_resource_group.myRG.location
  resource_group_name = azurerm_resource_group.myRG.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "mySubnet_name" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = azurerm_resource_group.myRG.name
  virtual_network_name = azurerm_virtual_network.myVNet.name
  address_prefixes     = [each.value]
}



resource "azurerm_network_security_group" "myNSG" {
  for_each = var.subnets

  name                = "${each.key}-nsg"
  location            = azurerm_resource_group.myRG.location
  resource_group_name = azurerm_resource_group.myRG.name

  dynamic "security_rule" {
    for_each = var.nsg_rules

    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}