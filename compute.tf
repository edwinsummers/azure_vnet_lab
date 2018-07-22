# Azure VNet Lab - Compute resources
#
# Lab space for testing virtual networking concepts across multiple VNets, subnets, and remote devices
#   This file includes the Compute resources - VMs and associated resources

resource "azurerm_virtual_machine" "host_11a" {
  name = "host_11a"
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  location = "${var.region}"
  vm_size = "${var.vm_size}"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name      = "${self.name}_osdisk"
    managed_disk_type = "Standard_LRS"
    create_option = "FromImage"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = "${file("${ssh_public_key_path}")}"
      path = "/home/${login_user}/.ssh/authorized_keys"
    }
  }

  network_interface_ids = []

  tags {
    Environment       = "${var.environment}"
    Project           = "${var.project}"
  }
}
