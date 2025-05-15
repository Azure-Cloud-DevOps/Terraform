variable "environment" {
  default = "prod"
}

variable "location" {
  default = "East US"
}

locals {
  rg_name = "rg-${var.environment}"
  tags = {
    env   = var.environment
    owner = "team@example.com"
  }
}

resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}
