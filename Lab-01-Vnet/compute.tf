#create a public IP address for VM1
resource "azurerm_public_ip" "pip_vm1" {
  name                = "pip-vm-lab01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}
#Create a Network Interface in Subnet1 of Vnet1
resource "azurerm_network_interface" "nic_vm1" {
    name                = "nic-vm-lab01"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "ipconfig1"
        subnet_id                     = azurerm_subnet.vnet1_subnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.pip_vm1.id
    }
    }

# Create a windows Virtual Machine in Subnet1 of Vnet1
resource "azurerm_windows_virtual_machine" "vm1" {
  name                = var.vm_name
  computer_name = "vm1lab01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic_vm1.id,

  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsserver"
    offer     = "windowsServer"
    sku       = "2025-datacenter-smalldisk"
    version   = "latest"
  }
}

