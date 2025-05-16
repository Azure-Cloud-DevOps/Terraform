output "resource_group_name" {
  value = azurerm_resource_group.my-rg.name
}

output "vnet_name" {
  value = azurerm_virtual_network.vent.name
}

output "subnet_ids" {
  value = { for k, subnet in azurerm_subnet.subnets : k => subnet.id }
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}

output "public_ip" {
  value = azurerm_public_ip.lb_pip.ip_address
}

output "lb_frontend_ip_config" {
  value = azurerm_lb.lb.frontend_ip_configuration
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.example.id
}

output "nat_gateway_public_ip" {
  value = azurerm_public_ip.natgwpip.ip_address
}
