# resource "azurerm_resource_group" "my-rg" {
#  name        = var.resource_group
#  location    = var.location
#}

resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "my-rg" {
  location    = var.location
  name        = "dev-${random_id.rg_name.hex}-rg"
}

resource "azurerm_virtual_network" "vent" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.my-rg.name
  address_space       = 10.0.0.0/16 #need to use variable
  location            = var.location
}

resource "azurerm_subnet" "subnet" {
  f

  
