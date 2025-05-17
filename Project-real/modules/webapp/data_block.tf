data "azurerm_app_service_plan" "prod_asp" {
  count               = var.environment == "ppr" ? 1 : 0
  name                = "existing-prod-appserviceplan"
  resource_group_name = "prod-resource-group"
}

