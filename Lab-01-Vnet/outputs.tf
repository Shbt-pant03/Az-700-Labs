output "vnet1_id" {
  value = azurerm_virtual_network.vnet1.id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vm_private_ip" {
  value = azurerm_network_interface.nic_vm1.private_ip_address
}

output "vm_public_ip" {
  value = azurerm_public_ip.pip_vm1.ip_address
}