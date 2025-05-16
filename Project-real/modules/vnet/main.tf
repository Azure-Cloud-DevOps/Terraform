resource "azurerm_resource_group" "my-rg" {
  name        = var.resource_group
  location    = var.location
}
