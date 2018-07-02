# Azure VNet Lab - Providers
#
# Lab space for testing virtual networking concepts across multiple VNets, subnets, and remote devices
#   This file includes the Terraform Providers required for resources

provider "azurerm" {
  environment = "public"
}
