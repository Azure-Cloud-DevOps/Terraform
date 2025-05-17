# resource "azurerm_resource_group" "my-rg" {
#  name        = var.resource_group
#  location    = var.location
#}

resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "my-rg" {
  location    = var.location
  name        = "tst-${random_id.rg_name.hex}-rg"
}

resource "azurerm_virtual_network" "vent" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.my-rg.name
  address_space       = [var.address_space]
  location            = var.location
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = azurerm_resource_group.my-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes      = [each.value.address_prefix]
}

resource "azurerm_network_security_group" "nsg" {
  name                 = var.nsg_name
  location             = azurerm_resource_group.my-rg.location
  resource_group_name  = azurerm_resource_group.my-rg.name
}

resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = {for rule in local.nsg_rules : rule.name => rule }
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.my-rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each                   = azurerm_subnet.subnets
  subnet_id                  = each.value.id
  network_security_group_id  = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface" "nic" {
  for_each            = azurerm_subnet.subnets
  name                = "${each.key}-nic"
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name

  ip_configuration {
    name                          = "internal"  
    subnet_id                     = each.value.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_route_table" "rt" {
  name                = var.route_table_name
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
}

resource "azurerm_route" "route" {
  name                   = "route-to-internet"
  resource_group_name    = azurerm_resource_group.my-rg.name
  route_table_name       = azurerm_route_table.rt.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "Internet"
}

resource "azurerm_subnet_route_table_association" "route_assoc" {
  for_each             = azurerm_subnet.subnets
  subnet_id            = each.value.id
  route_table_id       = azurerm_route_table.rt.id
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
