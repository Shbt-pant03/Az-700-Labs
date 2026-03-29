variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

variable "resource_group_name" {
  default = "rg-az700-lab01"
}

variable "location" {
  default = "East US"
}

variable "vnet1_name" {
  default = "vnet-hub-eastus"
}

variable "vnet2_name" {
  default = "vnet-spoke-eastus"
}