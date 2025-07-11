variable "rgname" {
  type           = string
  description    = "resource group name"
}

variable "location" {
  type          = string
  description   = "resource location"
  default       = "canadacentral"

#variable "storage_account_name" {
 # type = string
#}

variable "environment" {
  type = string
}

# Generate random suffix
resource "random_string" "storage_suffix" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}


variable "kubernetes_version" {
  default = "1.29.2"
}
