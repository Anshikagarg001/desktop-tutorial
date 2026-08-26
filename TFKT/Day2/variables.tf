variable "location" {
  description = "Azure region"
  type        = string

  default = "eastus"

  validation {
    condition     = contains(["eastus", "westus2"], var.location)
    error_message = "Location must be either eastus or westus2."
  }
}

variable "subnets" {
  description = "Subnet names and address prefixes"
  type        = map(string)

  default = {
    subnet1 = "10.0.1.0/24"
    subnet2 = "10.0.2.0/24"
    subnet3 = "10.0.3.0/24"
  }
}

variable "nsg_rules" {
  description = "NSG rules to apply to each subnet"
  type = map(object({
    priority  = number
    direction = string
    access    = string
    protocol  = string
    port      = string
  }))

  default = {
    allow_http = {
      priority  = 100
      direction = "Inbound"
      access    = "Allow"
      protocol  = "Tcp"
      port      = "80"
    }

    allow_https = {
      priority  = 110
      direction = "Inbound"
      access    = "Allow"
      protocol  = "Tcp"
      port      = "443"
    }
  }
}