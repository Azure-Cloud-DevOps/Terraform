terraform {
  required_providers {
    azurerm = {
      source = hasicorp/azurerm
      version = "~> 3.0"
    }
  required_version = ">= 1.0.0"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my-rg" {
  name = "my-rg"
  location = "East US"
}

resource "azurerm_storage_acount" "my-storage-account" {
  name = "mystorageaccount"
  resource_group_name = azurerm_resource_group.my-rg.name
  location = azurerm_resource_group.my-rg.location
  account_tier = "Standard"
  account_replication_type = "LRS"  
} 

resource "azurerm_storage_container" "my-container" {
  name = "my-container"
  storage_account_name = azurerm_storage_acount.my-storage-account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "my-blob" {
  name = "my-blob.txt"
  storage_account_name = azurerm_storage_acount.my-storage-account.name
  storage_container_name = azurerm_storage_container.my-container.name
  type = "Block"
  source = "path/to/local/file.txt"
}

output "storage_account_name" {
  value = azurerm_storage_acount.my-storage-account.name
}
output "storage_container_name" {
  value = azurerm_storage_container.my-container.name
}
output "storage_blob_name" {
  value = azurerm_storage_blob.my-blob.name
}
output "storage_blob_url" {
  value = azurerm_storage_blob.my-blob.url
}
output "storage_blob_properties" {
  value = azurerm_storage_blob.my-blob.properties
}
output "storage_blob_metadata" {
  value = azurerm_storage_blob.my-blob.metadata
}
