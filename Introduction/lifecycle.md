//main.tf
resource "azurerm_resource_group" "example" {
  name     = "${var.environment}-resources"
  location = var.location
 #location = var.allowed_locations[2]
  tags = {
    environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
    # ignore_changes = [ tags ]
    precondition {
      condition = contains(var.allowed_locations, var.location)
      error_message = "Please enter a valid location!"
    }
    
  }

}

resource "azurerm_storage_account" "example" {
   
  #count = length(var.storage_account_name)
  for_each = var.storage_account_name
  #name = var.storage_account_name(count.index)
  name                     = each.value
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = var.environment
  }

   lifecycle {
    create_before_destroy = true
    ignore_changes = [ account_replication_type ]
    replace_triggered_by = [ azurerm_resource_group.example.id ]
  }
}

//local.tf
locals {
  common_tags = {
    environment = var.environment
    lob = "banking"
    stage = "alpha"
  }
}

//output.tf
output "rgname" {
  value = azurerm_resource_group.example[*].name
}

output "storage_name" {
  value = [for i in azurerm_storage_account.example: i.name]
}

//variables.tf
variable "environment" {
    type = string
    description = "the env type"
    default = "prod"
}

variable "storage_disk" {
    type = number
    description = "the storage disk size of os"
    default = 80
  
}

variable "is_delete" {
  type = bool
  description = "the default behavior to os disk upon vm termination"
  default = true
}

variable "allowed_locations" {
    type = list(string)
    description = "list of allowed locations"
    default = [ "West Europe", "North Europe" , "East US" ]
  
}
variable "location" {
  default = "West Europe"
  type = string
  
}

variable "resource_tags" {
    type = map(string)
    description = "tags to apply to the resources"
    default = {
      "environment" = "staging"
      "managed_by" = "terraform"
      "department" = "devops"
    }
  
}

# Tuple type
variable "network_config" {
  type        = tuple([string, string, number])
  description = "Network configuration (VNET address, subnet address, subnet mask)"
  default     = ["10.0.0.0/16", "10.0.2.0", 24]
}


variable "allowed_vm_sizes" {
  type        = list(string)
  description = "Allowed VM sizes"
  default     = ["Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2"]
}

# Object type
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

variable "storage_account_name" {
  type = set(string)
  default = [ "techtutorials11", "techtutorials12" ]  
}
