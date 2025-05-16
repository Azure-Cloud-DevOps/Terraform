variable "resource_group" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type = list(string)
}

variable "subnets" {
  description = "Map of subnets with name as key and object with address_prefix"
  type = map(object(({
    address_prefix = string
  }))
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "nic_name" {
  description = "Name of the Network Interface"
  type        = string
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
}

variable "lb_name" {
  description = "Name of the Load Balancer"
  type = string
}


             
          
