resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name     = "tst-${random_id.rg_name.hex}-rg"
  location = var.location
}

output "name" {
  value = azurerm_resource_group.this.name
}

output "location" {
  value = azurerm_resource_group.this.location
}
