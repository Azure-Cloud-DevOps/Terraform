
understand the use the below type constraints

- Name: environment, type=string
- Name: storage-disk, type=number
- Name: is_delete, type=boolean
- Name: Allowed_locations, type=list(string)
- Name: resource_tags , type=map(string)
- Name: network_config , type=tuple([string, string, number])
- Name: allowed_vm_sizes, type=list(string)
- Name: vm_config,
```
## Object type:
---------------
variable "vm_config" {
  type = object({
    size         = string
    publisher    = string
    offer        = string
    sku          = string
    version      = string
  })
  description = "Virtual machine configuration"
  default = {
    size         = "Standard_DS1_v2"
    publisher    = "Canonical"
    offer        = "0001-com-ubuntu-server-jammy"
    sku          = "22_04-lts"
    version      = "latest"
  }
}

resource usage:
storage_image_reference {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = var.vm_config.sku
  version   = var.vm_config.version
}
***************************************************************
## set:
------
1. Define a set variable
variable "allowed_ports" {
  type = set(number)
  default = [22, 80, 443]
}

2. Use it in a resource
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  dynamic "security_rule" {
    for_each = var.allowed_ports
    content {
      name                       = "Allow-Port-${security_rule.value}"
      priority                   = 100 + index(sort(toList(var.allowed_ports)), security_rule.value)
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "${security_rule.value}"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

Example with Validation:
variable "regions" {
  type = set(string)
  default = ["eastus", "westeurope"]

  validation {
    condition     = alltrue([for r in var.regions : contains(["eastus", "westeurope", "centralus"], r)])
    error_message = "Each region must be one of eastus, westeurope, or centralus."
  }
}

**************************************************************************
## map:
------
variable "resource_tags" {
    type = map(string)
    description = "tags to apply to the resources"
    default = {
      "environment" = "staging"
      "managed_by" = "terraform"
      "department" = "devops"
    }

Resource usage:
tags = {
  environment = var.resource_tags["environment"]
  managed_by = var.resource_tags["managed_by"]
  department = var.resource_tags["department"]
}
**************************************************************************
## list:
-------
variable "allowed_locations" {
    type = list(string)
    description = "list of allowed locations"
    default = [ "West Europe", "North Europe" , "East US" ]
}

Resurce usage:
resource "azurerm_resource_group" "example" {
  name     = "${var.environment}-resources"
  location = var.allowed_locations[2]
}

*************************************************************************

