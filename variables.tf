# Azure VNet Lab - Variables

# Lab space for testing virtual networking concepts across multiple VNets, subnets, and remote devices
#   This file includes the Terraform Variables used in other files

variable "region" {
  description = "Azure region for all resources in this infrastructure"
  default     = "eastus2"
}

variable "vm_size" {
  description = "Instance size to use for virtual machines"
  default     = "Standard_B1S"
}

variable "admin_user" {
  description = "Username as administrator for virtual machines"
}

variable "public_ssh_key_path" {
  description = "Full path to public key on local machine to use for ssh login to virtual machines"
}

# Following are used for setting tags on resources
variable "environment" {
  default = "test"
}

variable "project" {
  default = "VNet Test Lab"
}
