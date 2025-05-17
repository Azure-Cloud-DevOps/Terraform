resource "azurerm_linux_virtual_machine_scale_set" "my-vmss" {
  name                = var.vmss_name
  location            = var.location
  resource_group_name  = azurerm_resource_group.my-rg.name
  vm_size             = var.vm_size
  instances           = var.instance_count
  admin_username      = var.admin_username
  # admin_password      = var.admin_password
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true
    for_each            = azurerm_subnet.subnets
    name                = "${each.key}-nic"

    ip_configuration {
      name                                   = "ipconfig-vmss"
      subnet_id                              =  each.value.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.lb_backend.id]
      primary                                = true
    }
  }

  upgrade_mode = "Manual"
}
