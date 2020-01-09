resource "azurerm_virtual_network" "main-VN" {
  name                = "${var.prefix}-VN"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  address_space       = ["10.0.0.0/16"]
 } 

resource "azurerm_subnet" "main-SN" {
  name                 = "${var.prefix}-SN"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main-VN.name}"
  address_prefix       = "10.0.1.0/24"
}
resource "azurerm_network_interface" "main-NI" {
  count                 = var.node_count
  name                = "${var.prefix}-NI-${count.index}"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  ip_configuration {
    name                          = "${var.prefix}-IP-${count.index}"
    subnet_id                     = "${azurerm_subnet.main-SN.id}"
    private_ip_address_allocation = "Dynamic"
  }
}
