## count
🔧 Basic Usage of count
Creating Multiple Azure Resource Groups
variable "resource_group_names" {
  type    = list(string)
  default = ["rg-dev", "rg-test", "rg-prod"]
}

resource "azurerm_resource_group" "example" {
  count    = length(var.resource_group_names)
  name     = var.resource_group_names[count.index]
  location = "East US"
}

🧠 Advanced Use Cases
Conditional Resource Creation
variable "create_storage_account" {
  type    = bool
  default = true
}

resource "azurerm_storage_account" "example" {
  count                    = var.create_storage_account ? 1 : 0
  name                     = "examplestorage${count.index}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

Using count with Modules
module "network" {
  source = "./modules/network"
  count  = 2

  resource_group_name = "rg-${count.index}"
  location            = "East US"
}

Dynamic Resource Naming
resource "azurerm_virtual_network" "example" {
  count               = 3
  name                = "vnet-${count.index}"
  address_space       = ["10.${count.index}.0.0/16"]
  location            = "East US"
  resource_group_name = azurerm_resource_group.example.name
}
