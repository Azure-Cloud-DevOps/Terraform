
1. Local Variables in Azure with Terraform:
Local variables in Terraform can be used to simplify and reuse expressions within your Azure infrastructure code. 

provider "azurerm" {
  features {}
}

locals {
  region        = "East US"
  vm_size       = "Standard_DS1_v2"
  image_publisher = "Canonical"
  image_offer   = "UbuntuServer"
  image_sku     = "18.04-LTS"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = local.region
}

data "azurerm_image" "ubuntu" {
  name                = "UbuntuServer"
  publisher            = local.image_publisher
  offer                = local.image_offer
  sku                  = local.image_sku
  most_recent          = true
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = local.region
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = local.region
  resource_group_name = azurerm_resource_group.example.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "example" {
  name                = "example-vm"
  location            = local.region
  resource_group_name = azurerm_resource_group.example.name
  network_interface_ids = [
    azurerm_network_interface.example.id
  ]
  vm_size             = local.vm_size
  storage_os_disk {
    name              = "example-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed           = true
  }
  os_profile {
    computer_name = "example-vm"
    admin_username = "adminuser"
    admin_password = "P@ssw0rd1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  source_image_reference {
    id = data.azurerm_image.ubuntu.id
  }
}


2. Data Block in Azure with Terraform (Querying Existing Resource):
provider "azurerm" {
  features {}
}

# Query an existing virtual network
data "azurerm_virtual_network" "existing_vnet" {
  name                = "existing-vnet"
  resource_group_name = "existing-resource-group"
}

resource "azurerm_subnet" "new_subnet" {
  name                 = "new-subnet"
  resource_group_name  = data.azurerm_virtual_network.existing_vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
