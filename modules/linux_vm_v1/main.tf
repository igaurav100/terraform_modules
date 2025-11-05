resource "azurerm_resource_group" "default" {
  count = var.resource_group_name == "" ? 1 : 0
  name     = var.vm_name != "" ? "rg-${var.vm_name}" : "rg-default"
  location = var.location
}

# Create VNet if subnet_id is not provided
resource "azurerm_virtual_network" "default" {
  count               = var.subnet_id == "" ? 1 : 0
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name != "" ? var.resource_group_name : azurerm_resource_group.default[0].name
}

# Create subnet if subnet_id is not provided
resource "azurerm_subnet" "default" {
  count                = var.subnet_id == "" ? 1 : 0
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name != "" ? var.resource_group_name : azurerm_resource_group.default[0].name
  virtual_network_name = azurerm_virtual_network.default[0].name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, 0)]
}


data "azurerm_resource_group" "myrg" {
  count = var.resource_group_name != "" ? 1 : 0
  name  = var.resource_group_name != "" ? var.resource_group_name : azurerm_resource_group.default[0].name
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