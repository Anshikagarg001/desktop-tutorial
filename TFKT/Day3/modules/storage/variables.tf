variable "storage_account_name" {
  description = "Name of the existing Storage Account"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group containing the Storage Account"
  type        = string
}

variable "location" {
  description = "Azure region of the Storage Account"
  type        = string
}