resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-IP"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  allocation_method   = "Static"
}

resource "azurerm_lb" "main" {
  name                = "${var.prefix}-LB"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
}

resource "azurerm_lb_backend_address_pool" "main" {
  resource_group_name = "${azurerm_resource_group.main.name}"
  loadbalancer_id     = "${azurerm_lb.main.id}"
  name                = "acctestpool"
}

resource "azurerm_network_interface_backend_address_pool_association" "main" {
  count                 = var.node_count
  network_interface_id    =  "${azurerm_network_interface.main-NI.${count.index}.id}
  ip_configuration_name   = "testconfiguration1"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.main.id}"
}