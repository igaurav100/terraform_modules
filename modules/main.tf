data "azurerm_resource_group" "myrg" {
  name = var.resource_group_name
}

// Network interface
resource "azurerm_network_interface" "myNic" {
  count               = var.vm_count
  name                = var.vm_name != "" ? "${var.vm_name}-nic-${count.index + 1}" : "myNic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "ip_configuration" {
    for_each = var.ip_configurations
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = "Dynamic"
    }
  }
}