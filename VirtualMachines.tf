  resource "azurerm_virtual_machine" "main-VM" {
  count                 = var.node_count
  name                  = "${var.prefix}-VM-${count.index}"
  location              = "${azurerm_resource_group.main.location}"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  network_interface_ids = [element(azurerm_network_interface.main-NI.*.id, count.index)]
  vm_size               = "Standard_DS1_v2"


  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.prefix}-OSD-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.prefix}-web-${count.index}"
    admin_username = "testadmin"
    
  }
  os_profile_linux_config {
    disable_password_authentication = false
 }
}
