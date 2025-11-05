data "azurerm_resource_group" "myrg" {
  name  = var.resource_group_name
}

resource "azurerm_network_interface" "mynic" {
  name                = "${var.vm_name}-nic-${count.index + 1}"
  count               = var.vm_count
  resource_group_name = var.resource_group_name != "" ? var.resource_group_name : azurerm_resource_group.default[0].name
  location            = var.location
  dynamic "ip_configuration" {
    for_each = var.ip_configurations
    content {
      name                          = "internal-${var.vm_name}-${count.index + 1}"
      subnet_id                     = var.subnet_id != "" ? var.subnet_id : azurerm_subnet.default[0].id
      private_ip_address_allocation = "Dynamic"
    }
  }
}