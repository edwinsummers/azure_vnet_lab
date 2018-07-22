# Azure VNet Lab - Compute resources
#
# Lab space for testing virtual networking concepts across multiple VNets, subnets, and remote devices
#   This file includes the Compute resources - VMs and associated resources

resource "azurerm_network_interface" "nic_host11a" {
  name                = "nic_host11a"
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  location            = "${var.region}"

  ip_configuration {
    name                          = "default"
    subnet_id                     = "${azurerm_subnet.subnet1_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.ip_host11a.id}"
  }
}

resource "azurerm_network_interface" "nic_host12a" {
  name                = "nic_host12a"
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  location            = "${var.region}"

  ip_configuration {
    name                          = "default"
    subnet_id                     = "${azurerm_subnet.subnet1_2.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.ip_host12a.id}"
  }
}

resource "azurerm_network_interface" "nic_host31a" {
  name                = "nic_host31a"
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  location            = "${var.region}"

  ip_configuration {
    name                          = "default"
    subnet_id                     = "${azurerm_subnet.subnet3_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.ip_host31a.id}"
  }
}

resource "azurerm_virtual_machine" "host_11a" {
  name                          = "host_11a"
  resource_group_name           = "${azurerm_resource_group.rg_vnetlab.name}"
  location                      = "${var.region}"
  vm_size                       = "${var.vm_size}"
  delete_os_disk_on_termination = true

  network_interface_ids = ["${azurerm_network_interface.nic_host11a.id}"]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "disk_host_11a"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "host-11a"
    admin_username = "${var.admin_user}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_user}/.ssh/authorized_keys"
      key_data = "${file(var.public_ssh_key_path)}"
    }
  }

  tags {
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

resource "azurerm_virtual_machine" "host_12a" {
  name                          = "host_12a"
  resource_group_name           = "${azurerm_resource_group.rg_vnetlab.name}"
  location                      = "${var.region}"
  vm_size                       = "${var.vm_size}"
  delete_os_disk_on_termination = true

  network_interface_ids = ["${azurerm_network_interface.nic_host12a.id}"]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "disk_host_12a"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "host-12a"
    admin_username = "${var.admin_user}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_user}/.ssh/authorized_keys"
      key_data = "${file(var.public_ssh_key_path)}"
    }
  }

  tags {
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

resource "azurerm_virtual_machine" "host_31a" {
  name                          = "host_31a"
  resource_group_name           = "${azurerm_resource_group.rg_vnetlab.name}"
  location                      = "${var.region}"
  vm_size                       = "${var.vm_size}"
  delete_os_disk_on_termination = true

  network_interface_ids = ["${azurerm_network_interface.nic_host31a.id}"]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "disk_host_31a"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "host-31a"
    admin_username = "${var.admin_user}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_user}/.ssh/authorized_keys"
      key_data = "${file(var.public_ssh_key_path)}"
    }
  }

  tags {
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

resource "azurerm_public_ip" "ip_host11a" {
  name                         = "ip_host11a"
  resource_group_name          = "${azurerm_resource_group.rg_vnetlab.name}"
  location                     = "${var.region}"
  sku                          = "basic"
  public_ip_address_allocation = "dynamic"
}

resource "azurerm_public_ip" "ip_host12a" {
  name                         = "ip_host12a"
  resource_group_name          = "${azurerm_resource_group.rg_vnetlab.name}"
  location                     = "${var.region}"
  sku                          = "basic"
  public_ip_address_allocation = "dynamic"
}

resource "azurerm_public_ip" "ip_host31a" {
  name                         = "ip_host31a"
  resource_group_name          = "${azurerm_resource_group.rg_vnetlab.name}"
  location                     = "${var.region}"
  sku                          = "basic"
  public_ip_address_allocation = "dynamic"
}

data "azurerm_public_ip" "ip_host11a" {
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  name                = "${azurerm_public_ip.ip_host11a.name}"
  depends_on          = ["azurerm_virtual_machine.host_11a"]
}

data "azurerm_public_ip" "ip_host12a" {
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  name                = "${azurerm_public_ip.ip_host12a.name}"
  depends_on          = ["azurerm_virtual_machine.host_12a"]
}

data "azurerm_public_ip" "ip_host31a" {
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  name                = "${azurerm_public_ip.ip_host31a.name}"
  depends_on          = ["azurerm_virtual_machine.host_31a"]
}

output "host_11a_public_ip" {
  value = "${data.azurerm_public_ip.ip_host11a.ip_address}"
}

output "host_11a_private_ip" {
  value = "${azurerm_network_interface.nic_host11a.private_ip_address}"
}

output "host_12a_public_ip" {
  value = "${data.azurerm_public_ip.ip_host12a.ip_address}"
}

output "host_12a_private_ip" {
  value = "${azurerm_network_interface.nic_host12a.private_ip_address}"
}

output "host_31a_public_ip" {
  value = "${data.azurerm_public_ip.ip_host31a.ip_address}"
}

output "host_31a_private_ip" {
  value = "${azurerm_network_interface.nic_host31a.private_ip_address}"
}
