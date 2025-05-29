provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "tm-rg"
  location = "eastus"
}

# Example: Primary App Service (Replace with your existing ones)
resource "azurerm_app_service_plan" "asp" {
  name                = "primary-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "primary" {
  name                = "primary-webapp-tm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
}

# Secondary App Service in another region
resource "azurerm_resource_group" "rg_secondary" {
  name     = "tm-rg-secondary"
  location = "westeurope"
}

resource "azurerm_app_service_plan" "asp_secondary" {
  name                = "secondary-asp"
  location            = azurerm_resource_group.rg_secondary.location
  resource_group_name = azurerm_resource_group.rg_secondary.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "secondary" {
  name                = "secondary-webapp-tm"
  location            = azurerm_resource_group.rg_secondary.location
  resource_group_name = azurerm_resource_group.rg_secondary.name
  app_service_plan_id = azurerm_app_service_plan.asp_secondary.id
}

# Traffic Manager Profile
resource "azurerm_traffic_manager_profile" "tm" {
  name                = "mytmprofile"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "global"

  traffic_routing_method = "Priority"

  dns_config {
    relative_name = "mytmexample"
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
}

# Add endpoints
resource "azurerm_traffic_manager_azure_endpoint" "primary_endpoint" {
  name                    = "primary-endpoint"
  profile_name            = azurerm_traffic_manager_profile.tm.name
  resource_group_name     = azurerm_resource_group.rg.name
  target_resource_id      = azurerm_app_service.primary.id
  type                    = "azureEndpoints"
  priority                = 1
}

resource "azurerm_traffic_manager_azure_endpoint" "secondary_endpoint" {
  name                    = "secondary-endpoint"
  profile_name            = azurerm_traffic_manager_profile.tm.name
  resource_group_name     = azurerm_resource_group.rg.name
  target_resource_id      = azurerm_app_service.secondary.id
  type                    = "azureEndpoints"
  priority                = 2
}
