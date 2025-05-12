current_time = timestamp()
resource_name = formatdate("YYYYMMDD",local.current_time)
tag_date = formatdate("DD-MM-YYYY",local.current_time)

#assignment 12
config_content = sensitive(file(config.json))

}

resource azurerm_resource_group rg {
name = "${local.formatted_name}-rg"
location = "westus2"

tags = local.merge_tags

}

resource "azurerm_storage_account" "example" {
   
  name = local.storage_formatted
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = local.merge_tags



}


# Create Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = "${local.formatted_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Here's where we need the dynamic block
  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.key
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range         = "*"
      destination_port_range    = security_rule.value.port
      source_address_prefix     = "*"
      destination_address_prefix = "*"
      description               = security_rule.value.description
    }
  }
}
output "rgname" {
  value = azurerm_resource_group.rg.name
}

output "storage_name" {
  value = azurerm_storage_account.example.name
}

output "nsg_rules" {
  value = local.nsg_rules
}

output "security_name" {
  value = azurerm_network_security_group.example.name
}

output "vm_size" {
  value = local.vm_size
}

output "backup" {
  value = var.backup_name
}

output "credential" {
    value = var.credential
    sensitive = true
  
}

output "unique_location" {
  value = local.unique_location
}

output "max_cost"{
    value = local.max_cost
}

output "positive" {
    value = local.positive_cost
  
}

output "resource_tag" {
    value = local.resource_name
  
}

output "config_loaded" {
  value = nonsensitive(jsondecode(local.config_content))
}

//variable.tf
variable "project_name" {
  type = string
  description = "name of the project"
  default = "Project ALPHA Resource"
}

variable "default_tags" {
    type = map(string)
    default = {
    company    = "CloudOps"
    managed_by = "terraform"
    }
}

variable "environment_tags" {
    type = map(string)
    default = {
    environment  = "production"
    cost_center = "cc-123"
    }
}

variable "storage_account_name" {
    type = string
    default = "techtutorIALS with!piyushthis should be formatted"
  
}

variable "allowed_ports" {
  type = string
  default = "80,443,3306"
}

variable "environment" {
  type = string
  description = "environment name"
  default = "dev"
  validation {
    condition = contains(["dev","staging","prod"], var.environment)
    error_message = "Enter the valid value for env:"
  }
}

variable "vm_sizes" {
    type = map(string)
    default = {
    dev     = "standard_D2s_v3",
    staging = "standard_D4s_v3",
    prod    = "standard_D8s_v3"
    }
  
}

variable "vm_size" {
    type = string
    default = "standard_D2s_v3"
    validation {
      condition = length(var.vm_size) >=2 && length(var.vm_size)<= 20
      error_message = "The vm_size should be between 2 and 20 chars"
    }
    validation {
      condition = strcontains(lower(var.vm_size),"standard")
      error_message = "The vm size should contains standard"
    }
  
}
#assignment 7
variable "backup_name" {
  default = "test_backup"
  type = string
  validation {
    condition = endswith(var.backup_name,"_backup")
    error_message = "Backup should ends with _backup"
  }
}

variable "credential" {
  default = "xyz123"
  type = string
  sensitive = true
}
