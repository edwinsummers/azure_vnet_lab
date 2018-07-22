# Azure VNet Lab - Variables

# Lab space for testing virtual networking concepts across multiple VNets, subnets, and remote devices
#   This file includes the Terraform Variables used in other files

# TODO: Query for preference on Windows vs Linux and select appropriate image based on region

variable "region" {
  default = "eastus2"
}

variable "environment" {
  default = "test"
}

variable "project" {
  default = "VNet Test Lab"
}

variable "vm_size" {
  default = "Basic_B1S"
}

variable "login_user" {
  description = "Base username to create for Linux hosts"
}

variable "ssh_public_key_path" {
  description = "Path to public key of pair used for ssh to hosts"
}