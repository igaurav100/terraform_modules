variable "resource_group_name" {
  type    = string
  default = "myrg"
}

variable "vm_count" {
  type    = number
  default = 1
}

variable "location" {
  type    = string
  default = "centralindia"
}

variable "vm_name" {
  type    = string
  default = "myvm"
}

variable "ip_configurations" {
  type = list(object({
    name      = string
    subnet_id = string
  }))
  default = [{
    name      = "internal"
    subnet_id = "/subscriptions/28c3c8ef-805a-4440-b2bf-7d16d637fb7c/resourceGroups/myrg/providers/Microsoft.Network/virtualNetworks/myvnet/subnets/default"
  }]
}