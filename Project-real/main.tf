# resource "azurerm_resource_group" "my-rg" {
#  name        = var.rgname
# location    = var.location
#}

module "vnet" {
  source = "./modules/vnet"  # Path to your module

  resource_group     = "my-rg"
  location           = "East US"
  vnet_name          = "my-vnet"
  address_space      = "10.0.0.0/16"

  subnets = {
    "frontend" = {
      address_prefix = "10.0.1.0/24"
    },
    "backend" = {
      address_prefix = "10.0.2.0/24"
    }
  }

  nsg_name           = "my-nsg"
  nic_name           = "my-nic"
  route_table_name   = "my-rt"
  lb_name            = "my-lb"
}


