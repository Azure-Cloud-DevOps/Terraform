
# Static
      resource "azurerm_network_security_rule" "nsg_rules" {
        for_each = { for rule in local.nsg_rules : rule.name => rule }
      
        name                        = each.value.name
        priority                    = each.value.priority
        direction                   = each.value.direction
        access                      = each.value.access
        protocol                    = each.value.protocol
        source_port_range           = each.value.source_port_range
        destination_port_range      = each.value.destination_port_range
        source_address_prefix       = each.value.source_address_prefix
        destination_address_prefix  = each.value.destination_address_prefix
        resource_group_name         = azurerm_resource_group.rg.name
        network_security_group_name = azurerm_network_security_group.nsg.name
      }


# Dynamic Expression, 
# Conditional Expression:
      condition ? true_value : false_value
    
    variable "environment" {
      type        = string
      description = "Environment name (e.g., dev, prod, staging)"
      default     = "dev"
    }

    resource "azurerm_network_security_group" "example" {
      name                = var.environment == "dev" ? "dev-nsg" : "stage-nsg"
      location            = azurerm_resource_group.rg.location
      resource_group_name = azurerm_resource_group.rg.name
      
      dynamic "security_rule" {
        for_each = local.nsg_rules
        content {
          name                       = security_rule.key
          priority                   = security_rule.value.priority
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range         = "*"
          destination_port_range    = security_rule.value.destination_port_range
          source_address_prefix     = "*"
          destination_address_prefix = "*"
          description               = security_rule.value.description
        }
      }
    }
# Splat Expression
  - Used to extract values from a list of resources or map outputs in a clean way.
          resource_type.resource_name[*].attribute
      
          output "public_ips" {
            value = azurerm_public_ip.example[*].ip_address
          }
          
          output "ip_names" {
            value = [for ip in azurerm_public_ip.example : ip.name]
          }

    # splat"
          output "splat" {
            value = var.account_names[1]
           #value = var.account_names[*]
           #value = local.nsg_rules[*]
           #value = local.nsg_rules[*].allow_http.description
          }

    # for loop. above one we will splat:
          output "demo" {
            value = [ for count in local.nsg_rules : count.description ]
          }


