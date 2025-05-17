locals {
  vm_list = {
    vm1 = { name = "vm1", subnet_key = "web" }
    vm2 = { name = "vm2", subnet_key = "web" }
    vm3 = { name = "vm3", subnet_key = "app" }
    vm4 = { name = "vm4", subnet_key = "app" }
    vm5 = { name = "vm5", subnet_key = "db" }
  }
}
