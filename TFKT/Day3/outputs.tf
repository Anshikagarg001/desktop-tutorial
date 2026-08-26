output "resource_group_name" {
  value = azurerm_resource_group.myRG.name
}

output "storage_account_id" {
  description = "Storage Account ID"
  value       = azurerm_storage_account.myStorage.id
  sensitive   = true
}