variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

variable "resource_group_name" {
  default = "rg-az700-lab01"
}

variable "location" {
  default = "North Central US"
}

variable "vnet1_name" {
  default = "vnet-hub-NCUS"
}

variable "vnet2_name" {
  default = "vnet-spoke-NCUS"
}

variable "vm_name" {
  default = "vm1-lab01"
}

variable "vm_size" {
  default = "Standard_D2s_v3"
}

variable "vm_linux_size" {
  default = "Standard_B2als_v2"
}

variable "admin_username" {
  default = "azureuser"
}

variable "admin_password" {}