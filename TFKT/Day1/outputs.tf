output "resource_group_name" {
  description = "Name of the Resource Group"
  value       = azurerm_resource_group.myRG.name
}

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.myVNet.id
}

output "subnet_id" {
  description = "IDs of all subnets"
  value       = { for key, subnet in azurerm_subnet.mySubnet : key => subnet.id }
}