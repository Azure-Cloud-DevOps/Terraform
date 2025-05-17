locals {
  asp_id = var.environment == "ppr" ? data.azurerm_app_service_plan.prod_asp[0].id : var.app_service_plan_id
}
