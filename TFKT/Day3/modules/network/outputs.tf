output "subnet_id" {
  description = "ID of the created subnet"
  value       = azurerm_subnet.this.id
}

output "nsg_id" {
  description = "ID of the created Network Security Group"
  value       = azurerm_network_security_group.this.id
}