output "dev_vnet_id" {
  value = azurerm_virtual_network.vnet.vnet_id
}

output "subnet_ids" {
  value = {
    for subnet in azurerm_subnet.subnets : subnet.name => subnet.id
  }
}

