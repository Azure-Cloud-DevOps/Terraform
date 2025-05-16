variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnets" {
  type = map(object(({
    address_prefix = string
  }))
}

variable "lb_name" {
  type = string
}

variable "route_table_name" {
  type = string
}

variable "nic_name" {
  type = string
}

             
          
