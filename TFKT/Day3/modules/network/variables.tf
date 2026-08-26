variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "address_prefix" {
  type        = string
  description = "Address prefix of the subnet"
}