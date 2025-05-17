variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name for the App Service Plan"
  type        = string
}

variable "webapp_name" {
  description = "Name for the Web App"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier for the App Service Plan"
  type        = string
  default     = "Basic"
}

variable "sku_size" {
  description = "SKU size for the App Service Plan"
  type        = string
  default     = "B1"
}

variable "dotnet_version" {
  description = "Dotnet version for the Web App"
  type        = string
  default     = "v6.0"
}

variable "app_settings" {
  description = "App settings for the Web App"
  type        = map(string)
  default     = {}
}
