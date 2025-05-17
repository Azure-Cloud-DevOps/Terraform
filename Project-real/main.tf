
module "resource_group" {
  source   = "./modules/resource_group"
  location = var.location
}

module "vnet" {
  source = "./modules/vnet" 
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


module "load_balancer" {
  source              = "./modules/load_balancer"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  lb_name             = var.lb_name
  zones               = var.zones
}

module "vmss" {
  source              = "./modules/vmss"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vmss_name           = var.vmss_name
  vm_size             = var.vm_size
  instance_count      = var.instance_count
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.network.subnet_ids["<your_subnet_key>"]  
  backend_pool_id     = module.load_balancer.backend_pool_id
}
