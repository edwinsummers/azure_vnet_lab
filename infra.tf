# Azure VNet Lab - Infrastructure resources
#
# Lab space for testing virtual networking concepts across multiple VNets, subnets, and remote devices
#   This file includes the VNet infrastructure - VNets, Subnets, Peerings, etc

# Note: The Virtual Networks below use in-line subnet definitions.
#   Terraform also supports separate subnet definitions, but in-line and separate cannot be
#   both used. For this lab environment, in-line was selected to ease readability.

resource "azurerm_resource_group" "rg_vnetlab" {
  name        = "rg_vnetlab"
  location    = "${var.region}"

  tags {
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.region}"

  subnet {
    name              = "subnet1_1"
    address_prefix    = "10.0.0.0/24"
  }

  subnet {
    name              = "subnet1_2"
    address_prefix    = "10.0.1.0/24"
  }

  tags {
    Environment       = "${var.environment}"
    Project           = "${var.project}"
  }
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  address_space       = ["10.0.1.0/24"]
  location            = "${var.region}"

  subnet {
    name              = "subnet2_1"
    address_prefix    = "10.0.1.0/24"
  }

  tags {
    Environment       = "${var.environment}"
    Project           = "${var.project}"
  }
}

resource "azurerm_virtual_network" "vnet3" {
  name                = "vnet3"
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  address_space       = ["10.1.0.0/16"]
  location            = "${var.region}"

  subnet {
    name              = "subnet3_1"
    address_prefix    = "10.1.1.0/24"
  }

  tags {
    Environment       = "${var.environment}"
    Project           = "${var.project}"
  }
}

resource "azurerm_virtual_network" "vnet4" {
  name                = "vnet4"
  resource_group_name = "${azurerm_resource_group.rg_vnetlab.name}"
  address_space       = ["10.2.0.0/16"]
  location            = "${var.region}"

  subnet {
    name              = "subnet4_1"
    address_prefix    = "10.2.0.0/24"
  }

  tags {
    Environment       = "${var.environment}"
    Project           = "${var.project}"
  }
}

resource "azurerm_virtual_network_peering" "peer1_3" {
  name                          = "peer1_3"
  resource_group_name           = "${azurerm_resource_group.rg_vnetlab.name}"
  virtual_network_name          = "${azurerm_virtual_network.vnet1.name}"
  remote_virtual_network_id     = "${azurerm_virtual_network.vnet3.id}"

  # The following optional parameters control special peering settings

  # Allow VMs in remote VNet to access VMs in local VNet; default = false
  allow_virtual_network_access  = false

  # Allow forwarded traffic from remote VMs; default = false
  allow_forwarded_traffic       = false

  # Allow remote VMs to use gateway (VPN, etc) in local VNet; default = false??
  allow_gateway_transit         = false

  # Allow local VMs to use gateway in remote VNet; default = false
  use_remote_gateways           = false
}

resource "azurerm_virtual_network_peering" "peer3_1" {
  name                          = "peer3_1"
  resource_group_name           = "${azurerm_resource_group.rg_vnetlab.name}"
  virtual_network_name          = "${azurerm_virtual_network.vnet3.name}"
  remote_virtual_network_id     = "${azurerm_virtual_network.vnet1.id}"

  # The following optional parameters control special peering settings

  # Allow VMs in remote VNet to access VMs in local VNet; default = false
  allow_virtual_network_access  = false

  # Allow forwarded traffic from remote VMs; default = false
  allow_forwarded_traffic       = false

  # Allow remote VMs to use gateway (VPN, etc) in local VNet; default = false??
  allow_gateway_transit         = false

  # Allow local VMs to use gateway in remote VNet; default = false
  use_remote_gateways           = false
}
