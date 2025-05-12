terraform {
  required_providers {
    azurerm = {
      source = "hasicorp/azurerm"
      version = "~> 4.8.0"
    }
  }
    required_version = ">=1.9.0"
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "East US"
  tags = {
    owner      = "example"
    organization = "neeworg"
  }
}

resource "azurerm_service_plan" "example" {
  name                = "example-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier     = "Standard"
    size     = "S1"
    capacity = 1
  }
  tags = {
    owner      = "example"
    organization = "neeworg"
  }
}

resource "azurerm_linux_web_app" "example" {
  name                = "example-linux-web-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    linux_fx_version = "DOCKER|nginx:latest"
    always_on        = true
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "WEBSITE_NODE_DEFAULT_VERSION" = "14"
  }

  tags = {
    owner      = "example"
    organization = "neeworg"
  }
}


##steps:
# terraform init
# terraform import azurerm_resource_group.rg <subscriptions/id/resourceGroups/myresourcerg
# terraform apply

# terraform plan -generate-config-out=generated.tf
#ref: https://www.youtube.com/watch?v=NDkJCQdjsZA
