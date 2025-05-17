resource "random_pet" "lb_hostname" {
}

# A public IP address for the load balancer
resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.lb_name}-pip"
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  domain_name_label   = "${azurerm_resource_group.my-rg.name}-${random_pet.lb_hostname.id}"
}

# A load balancer with a frontend IP configuration and a backend address pool
resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "myPublicIP"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend" {
  name            = "MyBackendAddressPool"
  loadbalancer_id = azurerm_lb.lb.id
}

#set up load balancer probe to check if the backend is up
resource "azurerm_lb_probe" "health_probe" {
  name                = "http-probe"
  resource_group_name = azurerm_resource_group.my-rg.name
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
}

#set up load balancer rule from azurerm_lb.example frontend ip to azurerm_lb_backend_address_pool.lb_backend backend ip port 80 to port 80
resource "azurerm_lb_rule" "lb_rule" {
  name                           = "http-rule"
  resource_group_name            = azurerm_resource_group.my-rg.name
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "myPublicIP"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.lb_backend.id
  probe_id                       = azurerm_lb_probe.health_probe.id
}


resource "azurerm_public_ip" "natgwpip" {
  name                = "natgw-publicIP"
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

#add nat gateway to enable outbound traffic from the backend instances
resource "azurerm_nat_gateway" "example" {
  name                    = "nat-Gateway"
  location                = azurerm_resource_group.my-rg.location
  resource_group_name     = azurerm_resource_group.my-rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_subnet_nat_gateway_association" "example" {
  for_each       = azurerm_subnet.subnets
  subnet_id      = each.value.id
  nat_gateway_id = azurerm_nat_gateway.example.id
}

# add nat gateway public ip association
resource "azurerm_nat_gateway_public_ip_association" "example" {
  public_ip_address_id = azurerm_public_ip.natgwpip.id
  nat_gateway_id       = azurerm_nat_gateway.example.id
}
