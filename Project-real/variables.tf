variable "rgname" {
  type           = string
  description    = "resource group name"
}

variable "location" {
  type          = string
  description   = "resource location"
  default       = "canadacentral"

#variable "storage_account_name" {
 # type = string
#}

# Generate random suffix
resource "random_string" "storage_suffix" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

# Compose storage account name
locals {
  storage_account_name = lower("${var.prefix}${random_string.storage_suffix.result}")
}

